// ignore_for_file: non_constant_identifier_names

import 'package:advisor/infrastructure/datasources/advisor_remote_datasource.dart';
import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:advisor/infrastructure/models/advice_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdvisorRemoteDatasource advisorRemoteDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    advisorRemoteDatasource = AdvisorRemoteDatasourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('advice_http_response.json'), 200));
  }

  void setUpMockClientFailure() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("getRandomAdviceFromAPI", () {
    final t_AdviceModel = AdviceModel(id: 1, advice: "test");

    test(
        "should perform GET request on a URL with Adive being the endpoint and header application/json",
        () {
      // arrange
      setUpMockClientSuccess();

      // act
      advisorRemoteDatasource.getRandomAdviceFromAPI();

      // assert
      verify(mockClient
          .get(Uri.parse('https://api.adviceslip.com/advice'), headers: {
        "Content-Type": "application/json",
      }));
    });

    test("should return valid advice when return is a success", () async {
      // arrange
      setUpMockClientSuccess();

      // act
      final result = await advisorRemoteDatasource.getRandomAdviceFromAPI();

      // assert
      expect(result, t_AdviceModel);
    });

    test("should throw ServerException if response is not 200", () async {
      // arrange
      setUpMockClientFailure();

      // act
      final call = advisorRemoteDatasource.getRandomAdviceFromAPI;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
