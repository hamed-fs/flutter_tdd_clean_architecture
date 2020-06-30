import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final NumberTriviaModel model = NumberTriviaModel(
    number: 10,
    text: '10 is the number of moons orbiting Earth.',
  );

  test('Sub Class of Number Trivia Entity Test.', () {
    // Assert
    expect(model, isA<NumberTriviaEntity>());
  });

  group('From Json =>', () {
    test('Integer Number Model Test.', () {
      // Arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      // Act
      final NumberTriviaModel result = NumberTriviaModel.fromJson(jsonMap);

      // Assert
      expect(result, model);
    });

    test('Double Number Model Test.', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      // Act
      final NumberTriviaModel result = NumberTriviaModel.fromJson(jsonMap);

      // Assert
      expect(result, model);
    });
  });

  group('To Json Test =>', () {
    test('Convert a Model to Json Object.', () {
      // Act
      final Map<String, dynamic> result = model.toJson();

      // Assert
      expect(
        result,
        {'text': '10 is the number of moons orbiting Earth.', 'number': 10},
      );
    });
  });
}
