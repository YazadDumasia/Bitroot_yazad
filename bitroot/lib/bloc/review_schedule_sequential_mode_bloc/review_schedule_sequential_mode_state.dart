part of 'review_schedule_sequential_mode_bloc.dart';

sealed class ReviewScheduleSequentialModeState extends Equatable {
  const ReviewScheduleSequentialModeState();

  @override
  List<Object> get props => [];
}

final class ReviewScheduleSequentialModeInitial
    extends ReviewScheduleSequentialModeState {}

final class ReviewScheduleSequentialModeLoading
    extends ReviewScheduleSequentialModeState {}

final class ReviewScheduleSequentialModeLoaded
    extends ReviewScheduleSequentialModeState {

  final List<Sequential>? sequentialList;

  const ReviewScheduleSequentialModeLoaded({required this.sequentialList});

  @override
  List<Object> get props => [sequentialList!];
}

final class ReviewScheduleSequentialModeError
    extends ReviewScheduleSequentialModeState {
  final String error_str;

  const ReviewScheduleSequentialModeError({required this.error_str});

  @override
  List<Object> get props => [error_str];
}

final class ReviewScheduleSequentialModeTimeOutError
    extends ReviewScheduleSequentialModeState {
  final String error_str;

  const ReviewScheduleSequentialModeTimeOutError({required this.error_str});

  @override
  List<Object> get props => [error_str];
}

final class ReviewScheduleSequentialModeNoInternet
    extends ReviewScheduleSequentialModeState {}
