// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../feature/contact/data/repository/contact_repository_impl.dart'
    as _i5;
import '../../../feature/contact/domain/repository/contact_repository.dart'
    as _i4;
import '../../../feature/contact/domain/usecase/get_contact_usecase.dart'
    as _i6;
import '../../../feature/contact/domain/usecase/search_contact_usecase.dart'
    as _i7;
import '../../../feature/contact/presentation/bloc/contact_bloc.dart' as _i8;
import '../app_module.dart' as _i9;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.Dio>(() => appModule.dio);
  gh.lazySingleton<_i4.ContactRepository>(
      () => _i5.ContactRepositoryImpl(gh<_i3.Dio>()));
  gh.lazySingleton<_i6.GetContactsUsecase>(
      () => _i6.GetContactsUsecase(gh<_i4.ContactRepository>()));
  gh.lazySingleton<_i7.SearchContactsUsecase>(
      () => _i7.SearchContactsUsecase(gh<_i4.ContactRepository>()));
  gh.factory<_i8.ContactBloc>(() => _i8.ContactBloc(
        gh<_i6.GetContactsUsecase>(),
        gh<_i7.SearchContactsUsecase>(),
      ));
  return getIt;
}

class _$AppModule extends _i9.AppModule {}
