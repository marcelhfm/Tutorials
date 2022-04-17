import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:advisor/infrastructure/models/advice_models.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

abstract class AdvisorRemoteDatasource {
  ///Requests a random advice from the API.
  ///Throws ServerException if respond code is not 200.
  Future<AdviceEntity> getRandomAdviceFromAPI();
}

class AdvisorRemoteDatasourceImpl implements AdvisorRemoteDatasource {
  final http.Client client;

  AdvisorRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromAPI() async {
    final response = await client
        .get(Uri.parse('https://api.adviceslip.com/advice'), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);

      return AdviceModel.fromJson(responseBody['slip']);
    }
  }
}
