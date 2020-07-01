import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_tdd_clean_architecture/core/errors/failures.dart';

abstract class GetNumberTriviaUsecase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}
