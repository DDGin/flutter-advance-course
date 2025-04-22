import 'package:dartz/dartz.dart';
import 'package:flutter_advance_course/data/data_source/local_data_source.dart';
import 'package:flutter_advance_course/data/data_source/remote_data_source.dart';
import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/data/network/error_handler.dart';
import 'package:flutter_advance_course/data/network/failure.dart';
import 'package:flutter_advance_course/data/network/network_info.dart';
import 'package:flutter_advance_course/data/request/request.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print("$error RepositoryImpl:33");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // if success, return right
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        print("$error RepositoryImpl:58");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print("$error RepositoryImpl:80");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      // get from cache
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      // we have cache error so we should call API
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // save response to local
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          print("$error RepositoryImpl");
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
