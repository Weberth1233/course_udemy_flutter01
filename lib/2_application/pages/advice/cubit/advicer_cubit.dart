import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerInitial());

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    debugPrint('fake get advice triggered');
    await Future.delayed(const Duration(seconds: 3), () {});
    debugPrint('got advice');
    emit(const AdvicerStateLoaded(advice: 'fake advice to test bloc'));
    // emit(const AdvicerStateError(message: 'error message'));
  }
}
