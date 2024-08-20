import 'dart:async';

import 'package:bitroot/models/models.dart';
import 'package:bitroot/repositories/repositories.dart';
import 'package:bitroot/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

part 'review_schedule_simultaneous_mode_event.dart';
part 'review_schedule_simultaneous_mode_state.dart';

class ReviewScheduleSimultaneousModeBloc extends Bloc<
    ReviewScheduleSimultaneousModeEvent, ReviewScheduleSimultaneousModeState> {
  final InternetConnectionChecker _connectionChecker;
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;

  ReviewScheduleSimultaneousModeBloc()
      : _connectionChecker = InternetConnectionChecker(),
        super(ReviewScheduleSimultaneousModeInitial()) {
    on<InitialLoadReviewScheduleSimultaneousModeEvent>(
        _handleInitialLoadingData);
    on<UpdateSliderValueSimultaneousModeReviewEvent>(_handleSliderValueUpdate);
    on<FinishSimultaneousModeReviewEvent>(_handleFinishSequentialModeReview);
    on<RefreshLoadReviewScheduleSimultaneousModeEvent>(
        _handleRefreshLoadingData);
    // Listen to the internet connection stream
    _connectionSubscription =
        _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        emit(ReviewScheduleSimultaneousModeNoInternet());
      } else {
        add(InitialLoadReviewScheduleSimultaneousModeEvent());
      }
    });
  }

  FertigationReviewModel? model;
  List<Sequential>? simultaneousList;

  final BehaviorSubject<ReviewScheduleSimultaneousModeState> _stateSubject =
      BehaviorSubject();

  Stream<ReviewScheduleSimultaneousModeState> get stateStream =>
      _stateSubject.stream;

  void emitState(ReviewScheduleSimultaneousModeState state) =>
      _stateSubject.sink.add(state);

  @override
  Future<void> close() {
    _stateSubject.close();
    _connectionSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _handleInitialLoadingData(
      InitialLoadReviewScheduleSimultaneousModeEvent event,
      Emitter<ReviewScheduleSimultaneousModeState> emit) async {
    bool hasConnection = await _connectionChecker.hasConnection;

    if (!hasConnection) {
      emit(ReviewScheduleSimultaneousModeNoInternet());
      return;
    }

    try {
      emit(ReviewScheduleSimultaneousModeLoading());
      await Future.delayed(
        Duration(seconds: 3),
      );
      Map<String, dynamic> result = await Repository.fetchReviewSchedule();
      if (result["isError"]) {
        // Check the type of error and handle it accordingly
        switch (result["errorType"]) {
          case "TimeoutException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Timeout - ${result["response"]}");
            // Handle timeout-specific logic here
            emit(ReviewScheduleSimultaneousModeTimeOutError(
                error_str: result["response"]));
            break;
          case "SocketException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: No Internet - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: No Internet - ${result["details"]}");
            // Handle no internet-specific logic here
            emit(ReviewScheduleSimultaneousModeNoInternet());
            break;
          case "FormatException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Bad Response Format - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Bad Response Format - ${result["details"]}");
            // Handle response format-specific logic here
            emit(ReviewScheduleSimultaneousModeError(
                error_str: result["response"]));
            break;
          case "ClientException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Client Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Client Error - ${result["details"]}");
            // Handle client-specific logic here
            emit(ReviewScheduleSimultaneousModeError(
                error_str: result["response"]));
            break;
          default:
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: General Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: General Error - ${result["details"]}");
            // Handle general error logic here
            emit(ReviewScheduleSimultaneousModeError(
                error_str: result["response"]));
            break;
        }
      } else {
        model = fertigationReviewModelFromJson(result["response"]);
        if (model != null &&
            model!.sequential != null &&
            (model!.sequential?.isNotEmpty ?? false)) {
          simultaneousList = model!.sequential;
        } else {
          simultaneousList = [];
        }

        emit(ReviewScheduleSimultaneousModeLoaded(
            simultaneousList: simultaneousList));
      }
    } catch (e) {
      emit(ReviewScheduleSimultaneousModeError(error_str: e.toString()));
    }
  }

  FutureOr<void> _handleSliderValueUpdate(
      UpdateSliderValueSimultaneousModeReviewEvent event,
      Emitter<ReviewScheduleSimultaneousModeState> emit) async {
    if (state is ReviewScheduleSimultaneousModeLoaded) {
      final currentState = state as ReviewScheduleSimultaneousModeLoaded;

      List<Sequential>? updatedItems;

      if (currentState.simultaneousList != null &&
          currentState.simultaneousList!.isNotEmpty) {
        updatedItems = List.from(currentState.simultaneousList!);
        // Update the specific item at the given index
        updatedItems[event.index] =
            updatedItems[event.index].copyWith(value: event.value);
      } else {
        updatedItems = [];
      }

      emit(
          ReviewScheduleSimultaneousModeLoaded(simultaneousList: updatedItems));
    }
  }

  FutureOr<void> _handleFinishSequentialModeReview(
      FinishSimultaneousModeReviewEvent event,
      Emitter<ReviewScheduleSimultaneousModeState> emit) async {}

  FutureOr<void> _handleRefreshLoadingData(
      RefreshLoadReviewScheduleSimultaneousModeEvent event,
      Emitter<ReviewScheduleSimultaneousModeState> emit) async {
    bool hasConnection = await _connectionChecker.hasConnection;

    if (!hasConnection) {
      emit(ReviewScheduleSimultaneousModeNoInternet());
      return;
    }

    try {
      Map<String, dynamic> result = await Repository.fetchReviewSchedule();
      if (result["isError"]) {
        // Check the type of error and handle it accordingly
        switch (result["errorType"]) {
          case "TimeoutException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Timeout - ${result["response"]}");
            // Handle timeout-specific logic here
            emit(ReviewScheduleSimultaneousModeTimeOutError(
                error_str: result["response"]));
            break;
          case "SocketException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: No Internet - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: No Internet - ${result["details"]}");
            // Handle no internet-specific logic here
            emit(ReviewScheduleSimultaneousModeNoInternet());
            break;
          case "FormatException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Bad Response Format - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Bad Response Format - ${result["details"]}");
            // Handle response format-specific logic here
            emit(ReviewScheduleSimultaneousModeError(
                error_str: result["response"]));
            break;
          case "ClientException":
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Client Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: Client Error - ${result["details"]}");
            // Handle client-specific logic here
            emit(ReviewScheduleSimultaneousModeError(
                error_str: result["response"]));
            break;
          default:
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: General Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSimultaneousModeBloc,
                "Error: General Error - ${result["details"]}");
            // Handle general error logic here
            emit(ReviewScheduleSimultaneousModeError(
                error_str: result["response"]));
            break;
        }
      } else {
        model = fertigationReviewModelFromJson(result["response"]);
        if (model != null &&
            model!.sequential != null &&
            (model!.sequential?.isNotEmpty ?? false)) {
          simultaneousList = model!.sequential;
        } else {
          simultaneousList = [];
        }

        emit(ReviewScheduleSimultaneousModeLoaded(
            simultaneousList: simultaneousList));
      }
    } catch (e) {
      emit(ReviewScheduleSimultaneousModeError(error_str: e.toString()));
    }
  }
}
