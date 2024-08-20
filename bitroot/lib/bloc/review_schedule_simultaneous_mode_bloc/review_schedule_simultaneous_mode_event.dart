part of 'review_schedule_simultaneous_mode_bloc.dart';

sealed class ReviewScheduleSimultaneousModeEvent extends Equatable {
  const ReviewScheduleSimultaneousModeEvent();

  @override
  List<Object> get props => [];
}

final class InitialLoadReviewScheduleSimultaneousModeEvent
    extends ReviewScheduleSimultaneousModeEvent {}

final class RefreshLoadReviewScheduleSimultaneousModeEvent
    extends ReviewScheduleSimultaneousModeEvent {}

final class UpdateSliderValueSimultaneousModeReviewEvent
    extends ReviewScheduleSimultaneousModeEvent {
  final int index;
  final double value;

  const UpdateSliderValueSimultaneousModeReviewEvent(
      {required this.index, required this.value});

  @override
  List<Object> get props => [index, value];
}

final class FinishSimultaneousModeReviewEvent
    extends ReviewScheduleSimultaneousModeEvent {}
