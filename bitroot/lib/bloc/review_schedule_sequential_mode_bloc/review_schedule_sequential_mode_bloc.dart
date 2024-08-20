import 'dart:async';

import 'package:bitroot/models/models.dart';
import 'package:bitroot/repositories/repositories.dart';
import 'package:bitroot/utils/components/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

part 'review_schedule_sequential_mode_event.dart';
part 'review_schedule_sequential_mode_state.dart';

class ReviewScheduleSequentialModeBloc extends Bloc<
    ReviewScheduleSequentialModeEvent, ReviewScheduleSequentialModeState> {
  final InternetConnectionChecker _connectionChecker;
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;

  ReviewScheduleSequentialModeBloc()
      : _connectionChecker = InternetConnectionChecker(),
        super(ReviewScheduleSequentialModeInitial()) {
    on<InitialLoadReviewScheduleEvent>(_handleInitialLoadingData);
    on<UpdateSliderValueSequentialModeReviewEvent>(_handleSliderValueUpdate);
    on<FinishSequentialModeReviewEvent>(_handleFinishSequentialModeReview);
    on<RefreshLoadReviewScheduleEvent>(_handleRefreshLoadingData);
    // Listen to the internet connection stream
    _connectionSubscription =
        _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        emit(ReviewScheduleSequentialModeNoInternet());
      } else {
        add(InitialLoadReviewScheduleEvent());
      }
    });
  }

  FertigationReviewModel? model;
  List<Sequential>? sequentialList;

  final BehaviorSubject<ReviewScheduleSequentialModeState> _stateSubject =
      BehaviorSubject();

  Stream<ReviewScheduleSequentialModeState> get stateStream =>
      _stateSubject.stream;

  void emitState(ReviewScheduleSequentialModeState state) =>
      _stateSubject.sink.add(state);

  @override
  Future<void> close() {
    _stateSubject.close();
    _connectionSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _handleInitialLoadingData(InitialLoadReviewScheduleEvent event,
      Emitter<ReviewScheduleSequentialModeState> emit) async {
    bool hasConnection = await _connectionChecker.hasConnection;

    if (!hasConnection) {
      emit(ReviewScheduleSequentialModeNoInternet());
      return;
    }

    try {
      emit(ReviewScheduleSequentialModeLoading());

      Map<String, dynamic> result = await Repository.fetchReviewSchedule();
      if (result["isError"]) {
        // Check the type of error and handle it accordingly
        switch (result["errorType"]) {
          case "TimeoutException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Timeout - ${result["response"]}");
            // Handle timeout-specific logic here
            emit(ReviewScheduleSequentialModeTimeOutError(
                error_str: result["response"]));
            break;
          case "SocketException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: No Internet - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: No Internet - ${result["details"]}");
            // Handle no internet-specific logic here
            emit(ReviewScheduleSequentialModeNoInternet());
            break;
          case "FormatException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Bad Response Format - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Bad Response Format - ${result["details"]}");
            // Handle response format-specific logic here
            emit(ReviewScheduleSequentialModeError(
                error_str: result["response"]));
            break;
          case "ClientException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Client Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Client Error - ${result["details"]}");
            // Handle client-specific logic here
            emit(ReviewScheduleSequentialModeError(
                error_str: result["response"]));
            break;
          default:
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: General Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: General Error - ${result["details"]}");
            // Handle general error logic here
            emit(ReviewScheduleSequentialModeError(
                error_str: result["response"]));
            break;
        }
      } else {
        model = fertigationReviewModelFromJson(result["response"]);
        if (model != null &&
            model!.sequential != null &&
            (model!.sequential?.isNotEmpty ?? false)) {
          sequentialList = model!.sequential;
        } else {
          sequentialList = [];
        }

        emit(
            ReviewScheduleSequentialModeLoaded(sequentialList: sequentialList));
      }
    } catch (e) {
      emit(ReviewScheduleSequentialModeError(error_str: e.toString()));
    }
  }

  FutureOr<void> _handleSliderValueUpdate(
      UpdateSliderValueSequentialModeReviewEvent event,
      Emitter<ReviewScheduleSequentialModeState> emit) {
    if (state is ReviewScheduleSequentialModeLoaded) {
      final currentState = state as ReviewScheduleSequentialModeLoaded;

      List<Sequential>? updatedItems;

      if (currentState.sequentialList != null &&
          currentState.sequentialList!.isNotEmpty) {
        updatedItems = List.from(currentState.sequentialList!);
        // Update the specific item at the given index
        updatedItems[event.index] =
            updatedItems[event.index].copyWith(value: event.value);
      } else {
        updatedItems = [];
      }

      emit(ReviewScheduleSequentialModeLoaded(sequentialList: updatedItems));
    }
  }

  FutureOr<void> _handleFinishSequentialModeReview(
      FinishSequentialModeReviewEvent event,
      Emitter<ReviewScheduleSequentialModeState> emit) {}

  Future<void> _handleRefreshLoadingData(RefreshLoadReviewScheduleEvent event,
      Emitter<ReviewScheduleSequentialModeState> emit) async {
    bool hasConnection = await _connectionChecker.hasConnection;

    if (!hasConnection) {
      emit(ReviewScheduleSequentialModeNoInternet());
      return;
    }

    try {
      Map<String, dynamic> result = await Repository.fetchReviewSchedule();
      if (result["isError"]) {
        // Check the type of error and handle it accordingly
        switch (result["errorType"]) {
          case "TimeoutException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Timeout - ${result["response"]}");
            // Handle timeout-specific logic here
            emit(ReviewScheduleSequentialModeTimeOutError(
                error_str: result["response"]));
            break;
          case "SocketException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: No Internet - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: No Internet - ${result["details"]}");
            // Handle no internet-specific logic here
            emit(ReviewScheduleSequentialModeNoInternet());
            break;
          case "FormatException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Bad Response Format - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Bad Response Format - ${result["details"]}");
            // Handle response format-specific logic here
            emit(ReviewScheduleSequentialModeError(
                error_str: result["response"]));
            break;
          case "ClientException":
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Client Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: Client Error - ${result["details"]}");
            // Handle client-specific logic here
            emit(ReviewScheduleSequentialModeError(
                error_str: result["response"]));
            break;
          default:
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: General Error - ${result["response"]}");
            Constants.debugLog(ReviewScheduleSequentialModeBloc,
                "Error: General Error - ${result["details"]}");
            // Handle general error logic here
            emit(ReviewScheduleSequentialModeError(
                error_str: result["response"]));
            break;
        }
      } else {
        model = fertigationReviewModelFromJson(result["response"]);
        if (model != null &&
            model!.sequential != null &&
            (model!.sequential?.isNotEmpty ?? false)) {
          sequentialList = model!.sequential;
        } else {
          sequentialList = [];
        }

        emit(
            ReviewScheduleSequentialModeLoaded(sequentialList: sequentialList));
      }
    } catch (e) {
      emit(ReviewScheduleSequentialModeError(error_str: e.toString()));
    }
  }
}
