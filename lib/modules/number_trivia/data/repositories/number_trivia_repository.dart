import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_tdd_clean_architecture/core/errors/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/platform/network_information.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository_contract.dart';

class NumberTriviaRepository implements NumberTriviaRepositoryContract {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInformation networkInformation;

  NumberTriviaRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInformation,
  });

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
    int number,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia() {
    throw UnimplementedError();
  }
}
