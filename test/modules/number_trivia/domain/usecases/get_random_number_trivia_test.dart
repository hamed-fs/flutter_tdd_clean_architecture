import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_architecture/core/usecases/get_number_trivia_usecase.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  MockNumberTriviaRepository repository;
  GetRandomNumberTriviaUsecase usecase;

  final NumberTriviaEntity testNumberTrivia = NumberTriviaEntity(
    number: 1,
    text: 'result',
  );

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTriviaUsecase(repository);
  });

  test('Get Trivia form Repository Test.', () async {
    // Arrange
    when(repository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(testNumberTrivia));

    //Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(testNumberTrivia));
    verify(repository.getRandomNumberTrivia());
    verifyNoMoreInteractions(repository);
  });
}
