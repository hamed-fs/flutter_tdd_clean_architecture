import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/platform/network_information.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInformation extends Mock implements NetworkInformation {}

void main() {
  NumberTriviaRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInformation mockNetworkInformation;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInformation = MockNetworkInformation();

    repository = NumberTriviaRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInformation: mockNetworkInformation,
    );
  });

  void runTestsOnline(Function body) {
    group('Device is Online =>', () {
      setUp(() => when(mockNetworkInformation.isConnected)
          .thenAnswer((_) async => true));

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('Device is Online =>', () {
      setUp(() => when(mockNetworkInformation.isConnected)
          .thenAnswer((_) async => false));

      body();
    });
  }

  group('Get Concrete Number Trivia =>', () {
    final int number = 1;
    final NumberTriviaModel model = NumberTriviaModel(
      number: number,
      text: 'Test Trivia.',
    );
    final NumberTriviaEntity entity = model;

    test('Device is Online Test.', () async {
      // Arrange
      when(mockNetworkInformation.isConnected).thenAnswer((_) async => true);

      // Act
      repository.getConcreteNumberTrivia(number);

      // Assert
      verify(mockNetworkInformation.isConnected);
    });

    runTestsOnline(() {
      test('Fetch Remote Data Test.', () async {
        // Arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => model);

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number);

        // Assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(number));
        expect(result, Right(entity));
      });

      test('Fetch Cache Data Test.', () async {
        // Arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => model);

        // Act
        await repository.getConcreteNumberTrivia(number);

        // Assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(number));
        verify(mockLocalDataSource.cacheNumberTrivia(model));
      });

      test('Fetch Remote Data Return Server Failure Test.', () async {
        // Arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number);

        // Assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(number));
        verifyZeroInteractions(mockLocalDataSource);

        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('Fetch Last Cache Data Test.', () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => model);

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());

        expect(result, Right(entity));
      });

      test('No Cache Data Test.', () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());

        expect(result, Left(CacheFailure()));
      });
    });
  });

  group('Get Random Number Trivia =>', () {
    final int number = 123;
    final NumberTriviaModel model = NumberTriviaModel(
      number: number,
      text: 'Test Trivia.',
    );
    final NumberTriviaEntity entity = model;

    test('Device is Online Test.', () async {
      // Arrange
      when(mockNetworkInformation.isConnected).thenAnswer((_) async => true);

      // Act
      repository.getRandomNumberTrivia();

      // Assert
      verify(mockNetworkInformation.isConnected);
    });

    runTestsOnline(() {
      test('Fetch Remote Data Test.', () async {
        // Arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => model);

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // Assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, Right(entity));
      });

      test('Fetch Cache Data Test.', () async {
        // Arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => model);

        // Act
        await repository.getRandomNumberTrivia();

        // Assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(model));
      });

      test('Fetch Remote Data Return Server Failure Test.', () async {
        // Arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // Assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);

        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('Fetch Last Cache Data Test.', () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => model);

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());

        expect(result, Right(entity));
      });

      test('No Cache Data Test.', () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

        // Act
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());

        expect(result, Left(CacheFailure()));
      });
    });
  });
}
