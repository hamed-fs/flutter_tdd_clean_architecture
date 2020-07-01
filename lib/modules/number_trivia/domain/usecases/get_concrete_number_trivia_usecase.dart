import 'package:dartz/dartz.dart';

import 'package:flutter_tdd_clean_architecture/core/errors/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/usecases/get_number_trivia_usecase.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository_contract.dart';

class GetConcreteNumberTriviaUsecase
    implements GetNumberTriviaUsecase<NumberTriviaEntity, int> {
  final NumberTriviaRepositoryContract repository;

  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(int number) =>
      repository.getConcreteNumberTrivia(number);
}
