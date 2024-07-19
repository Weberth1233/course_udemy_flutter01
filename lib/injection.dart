import 'dart:ffi';

import 'package:advicer/0_data/datasources/advice_remote_datasources.dart';
import 'package:advicer/0_data/repositories/advice_repository_impl.dart';
import 'package:advicer/1_domain/repositories/advice_repository.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  // ! application Layer
  // Factory = every time a new/fresh instance of that class
  //sl() - a injeção vai saber qual usecase é necessário para ela iniciar, pois o usecase vai está injetado nesse arquivo
  sl.registerFactory(() => AdvicerCubit(adviceUseCases: sl()));
  // ! domain Layer
  //Injectando o useCase que vai ser usando no cubit que tá em cima pelo sl()
  //sl() - a injeção vai saber qual repositorio é necessário para ela iniciar, pois o repositorio vai está injetado nesse arquivo
  sl.registerFactory(() => AdviceUseCases(adviceRepository: sl()));

  // ! data Layer
  //Injetando o repositorio que vai ser usado pelo meu usecase
  sl.registerFactory<AdviceRepository>(
      () => AdviceRepositoryImpl(adviceRemoteDatasource: sl()));
  //Injetando meu datasource que vai usar minha dependencia externa do http.Client() que está injetada abaixo
  sl.registerFactory<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImpl(client: sl()));

  // ! externs - http é uma injeção externa que vai ser usado no meu datasources
  sl.registerFactory(() => http.Client());
}
