part of 'review_schedule_simultaneous_mode_bloc.dart';

sealed class ReviewScheduleSimultaneousModeState extends Equatable {
  const ReviewScheduleSimultaneousModeState();

  @override
  List<Object> get props => [];
}

final class ReviewScheduleSimultaneousModeInitial
    extends ReviewScheduleSimultaneousModeState {}

final class ReviewScheduleSimultaneousModeLoading
    extends ReviewScheduleSimultaneousModeState {}

final class ReviewScheduleSimultaneousModeLoaded
    extends ReviewScheduleSimultaneousModeState {
  final List<Sequential>? simultaneousList;

  const ReviewScheduleSimultaneousModeLoaded({required this.simultaneousList});

  @override
  List<Object> get props => [simultaneousList!];
}

final class ReviewScheduleSimultaneousModeError
    extends ReviewScheduleSimultaneousModeState {
  final String error_str;

  const ReviewScheduleSimultaneousModeError({required this.error_str});

  @override
  List<Object> get props => [error_str];
}

final class ReviewScheduleSimultaneousModeTimeOutError
    extends ReviewScheduleSimultaneousModeState {
  final String error_str;

  const ReviewScheduleSimultaneousModeTimeOutError({required this.error_str});

  @override
  List<Object> get props => [error_str];
}

final class ReviewScheduleSimultaneousModeNoInternet
    extends ReviewScheduleSimultaneousModeState {}
