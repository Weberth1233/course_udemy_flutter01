import 'package:advicer/0_data/datasources/advice_remote_datasources.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/0_data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group("AdviceRemoteDatasource", () {
    group("should return AdviceModel", () {
      test("when Client response was 200 and has valid data", () async {
        //Iniciando o mock do httpclient
        final mockClient = MockClient();
        //Injetando como dependencia do meu datasource o meu mockClien do http para simular a requisição e a resposta
        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDatasourceImpl(client: mockClient);
        //simulando uma resposta da api
        const responseBody = '{"advice": "test advice", "advice_id": 1}';
        //Quando o mockClient fizer um get nessa url então o valor futuro deve ser a resposta simulado acima com o status code 200
        when(
          mockClient.get(
              Uri.parse('https://api.flutter-community.com/api/v1/advice'),
              headers: {
                'content-type': 'application/json',
              }),
        ).thenAnswer(
          (realInvocation) => Future.value(
            Response(responseBody, 200),
          ),
        );
        //Essa função vai fazer o get e vai usar o mockClient acima como resultado
        final result =
            await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();
        //Vou comparar o resultado esperado
        expect(result, AdviceModel(advice: "test advice", id: 1));
      });
    });
    // group('should throw', () {
    //   test('a ServerException when Client response was not 200', () {
    //     final mockClient = MockClient();
    //     final adviceRemoteDatasourceUnderTest =
    //         AdviceRemoteDatasourceImpl(client: mockClient);

    //     when(mockClient.get(
    //       Uri.parse('https://api.flutter-community.com/api/v1/advice'),
    //       headers: {
    //         'content-type': 'application/json ',
    //       },
    //     )).thenAnswer((realInvocation) => Future.value(Response('', 201)));
    //     final response =
    //         adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();
    //     expect(() => response, throwsA(isA<ServerException>()));
    //   });
    // });
  });
}
