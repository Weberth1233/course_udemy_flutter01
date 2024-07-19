import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../1_domain/failures/failures.dart';

part 'advicer_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  final AdviceUseCases adviceUseCases;
  AdvicerCubit({required this.adviceUseCases}) : super(AdvicerInitial());

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    debugPrint('fake get advice triggered');
    //Gerencia de estado faz a chamada do usecase da camada de domain
    final result = await adviceUseCases.getAdvice();
    result.fold(
        (failure) =>
            emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
    debugPrint('got advice');
    // emit(const AdvicerStateError(message: 'error message'));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (CacheFailure):
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
