import 'package:dartz/dartz.dart';
import 'package:test_app_project/core/utils/failure.dart';
import 'package:test_app_project/feature/contact/data/models/contact_model.dart';
import 'package:test_app_project/feature/contact/domain/entity/contact_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactModel>>> getContacts(ContactParamEntity data);
  Future<Either<Failure, List<ContactModel>>> searchContacts(ContactParamEntity data);
}
