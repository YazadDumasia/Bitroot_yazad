part of 'review_schedule_sequential_mode_bloc.dart';

sealed class ReviewScheduleSequentialModeEvent extends Equatable {
  const ReviewScheduleSequentialModeEvent();

  @override
  List<Object> get props => [];
}

final class InitialLoadReviewScheduleEvent
    extends ReviewScheduleSequentialModeEvent {}

final class RefreshLoadReviewScheduleEvent
    extends ReviewScheduleSequentialModeEvent {}

final class UpdateSliderValueSequentialModeReviewEvent
    extends ReviewScheduleSequentialModeEvent {
  final int index;
  final double value;

  const UpdateSliderValueSequentialModeReviewEvent(
      {required this.index, required this.value});

  @override
  List<Object> get props => [index, value];
}

final class FinishSequentialModeReviewEvent
    extends ReviewScheduleSequentialModeEvent {}