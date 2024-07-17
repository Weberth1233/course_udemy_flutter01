part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState {}

final class AdvicerInitial extends AdvicerState {}

class AdviceStateLoading extends AdvicerState {}

class AdviceStateLoaded extends AdvicerState {
  final String advice;
  AdviceStateLoaded({required this.advice});
}

class AdviceStateError extends AdvicerState {
  final String message;
  AdviceStateError({required this.message});
}
