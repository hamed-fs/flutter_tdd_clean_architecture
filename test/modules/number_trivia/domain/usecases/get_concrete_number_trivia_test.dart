import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository_contract.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepositoryContract {}

void main() {
  MockNumberTriviaRepository repository;
  GetConcreteNumberTriviaUsecase usecase;

  final int testNumber = 1;
  final NumberTriviaEntity testNumberTrivia = NumberTriviaEntity(
    number: testNumber,
    text: 'result',
  );

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTriviaUsecase(repository);
  });

  test('Get Trivia for the Number form Repository Test.', () async {
    // Arrange
    when(repository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(testNumberTrivia));

    //Act
    final result = await usecase(testNumber);

    // Assert
    expect(result, Right(testNumberTrivia));
    verify(repository.getConcreteNumberTrivia(testNumber));
    verifyNoMoreInteractions(repository);
  });
}
