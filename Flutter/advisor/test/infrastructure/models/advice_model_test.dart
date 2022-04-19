// ignore_for_file: unnecessary_type_check, non_constant_identifier_names

import 'dart:convert';

import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/infrastructure/models/advice_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final t_AdviceModel = AdviceModel(advice: "test", id: 1);

  test("model should be subclass of AdviceEntity", () {
    // assert
    expect(t_AdviceModel, isA<AdviceEntity>());
  });

  group("fromJSON", () {
    test("should return a valid model if JSON Advice is correct", () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("advice.json"));

      // act
      final result = AdviceModel.fromJson(jsonMap);

      // assert
      expect(result, t_AdviceModel);
    });
  });
}
