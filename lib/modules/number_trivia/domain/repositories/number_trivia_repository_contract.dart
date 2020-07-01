import 'package:dartz/dartz.dart';

import 'package:flutter_tdd_clean_architecture/core/errors/failures.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaRepositoryContract {
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
    int number,
  );

  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia();
}
