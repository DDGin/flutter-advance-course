import 'package:dartz/dartz.dart';
import 'package:flutter_advance_course/data/network/failure.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/repository/repository.dart';
import 'package:flutter_advance_course/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository _repository;

  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _repository.getStoreDetails1();
  }
}
