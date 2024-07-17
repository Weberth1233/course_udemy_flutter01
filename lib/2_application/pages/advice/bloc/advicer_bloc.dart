import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdvicerEvent>((event, emit) async {
      // TODO: implement event handler
      //Primeiramente vou emitir um estado de loading
      emit(AdviceStateLoading());
      debugPrint('Fake get advice triggered');
      await Future.delayed(const Duration(seconds: 3), () {});
      //Caso os dados sejam obtidos é emitido o estado de loaded com o conselho que a api vai retornar
      debugPrint('got advice');
      // emit(AdviceStateLoaded(advice: 'Fake advice to test bloc'));
      //Caso de algum erro - será emitido um estaod de error
      emit(AdviceStateError(message: 'Error message'));
    });
  }
}
