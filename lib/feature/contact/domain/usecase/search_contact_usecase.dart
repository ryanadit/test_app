import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app_project/core/utils/failure.dart';
import 'package:test_app_project/core/utils/usecase.dart';
import 'package:test_app_project/feature/contact/data/models/contact_model.dart';
import 'package:test_app_project/feature/contact/domain/entity/contact_entity.dart';
import 'package:test_app_project/feature/contact/domain/repository/contact_repository.dart';

@lazySingleton
class SearchContactsUsecase extends UseCase<List<ContactModel>, ContactParamEntity> {
  final ContactRepository _contactRepository;
  const SearchContactsUsecase(this._contactRepository);

  @override
  Future<Either<Failure, List<ContactModel>>> call(ContactParamEntity params) async {
    return await _contactRepository.searchContacts(params);
  }

}