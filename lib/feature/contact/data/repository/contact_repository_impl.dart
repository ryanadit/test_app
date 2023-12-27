import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app_project/core/helpers/url_helper.dart';
import 'package:test_app_project/core/utils/failure.dart';
import 'package:test_app_project/feature/contact/data/models/contact_model.dart';
import 'package:test_app_project/feature/contact/domain/entity/contact_entity.dart';
import 'package:test_app_project/feature/contact/domain/repository/contact_repository.dart';

@LazySingleton(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  final Dio _dio;
  ContactRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, List<ContactModel>>> getContacts(ContactParamEntity data) async {
    try {
      List<ContactModel> contacts = [];
      final response = await _dio.get(
        UrlHelper.contactApi,
        queryParameters: data.toJsonParam(),
      );
      final result = response.data;
      if (result is List) {
        for (var item in result) {
          contacts.add(ContactModel.fromJson(item));
        }
      }
      return Right(contacts);
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Left(FailedResponse(error: 'Contact not found'));
      }
      return Left(FailedResponse(error: 'Something wrong'));
    } catch (error) {
      return Left(FailedResponse(error: 'error : $error'));
    }
  }
  
  @override
  Future<Either<Failure, List<ContactModel>>> searchContacts(ContactParamEntity data) async {
    try {
      List<ContactModel> contacts = [];
      final response = await _dio.get(
        UrlHelper.contactApi,
        queryParameters: data.toJsonParamSearch(),
      );
      final result = response.data;
      if (result is List) {
        for (var item in result) {
          contacts.add(ContactModel.fromJson(item));
        }
      }
      return Right(contacts);
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Left(FailedResponse(error: 'Contact not found'));
      }
      return Left(FailedResponse(error: 'Something wrong'));
    } catch (error) {
      return Left(FailedResponse(error: 'error : $error'));
    }
  }
 
}