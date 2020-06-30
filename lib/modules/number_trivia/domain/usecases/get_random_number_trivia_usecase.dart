import 'package:dartz/dartz.dart';

import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/usecases/get_number_trivia_usecase.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTriviaUsecase
    implements GetNumberTriviaUsecase<NumberTriviaEntity, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams param) =>
      repository.getRandomNumberTrivia();
}
