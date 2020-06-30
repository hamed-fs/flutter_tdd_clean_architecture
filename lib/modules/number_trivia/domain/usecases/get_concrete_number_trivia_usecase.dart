import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase(this.repository);

  Future<Either<Failure, NumberTriviaEntity>> execute({@required int number}) =>
      repository.getConcreteNumberTrivia(number);
}
