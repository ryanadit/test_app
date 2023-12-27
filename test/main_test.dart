import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test_app_project/core/config/dio_config.dart';
import 'package:test_app_project/feature/contact/data/repository/contact_repository_impl.dart';
import 'package:test_app_project/feature/contact/domain/entity/contact_entity.dart';
import 'package:test_app_project/feature/contact/domain/repository/contact_repository.dart';
import 'package:test_app_project/feature/contact/domain/usecase/get_contact_usecase.dart';
import 'package:test_app_project/feature/contact/domain/usecase/search_contact_usecase.dart';
import 'package:test_app_project/feature/contact/presentation/bloc/contact_bloc.dart';


void main() {
  mainTest();
}

void mainTest() {
  final dio = DioConfig.dio();
  late DioAdapter dioAdapter;

  setUp(() {
    dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    dio.httpClientAdapter = dioAdapter;
  });
  
  ContactRepository contactRepository = ContactRepositoryImpl(dio);
  final usecaseSearchContact = SearchContactsUsecase(contactRepository);
  final usecaseGetContact = GetContactsUsecase(contactRepository);

  group('ContactBloc', () {
    blocTest(
      'Cancel Search', 
      build: () => ContactBloc(usecaseGetContact, usecaseSearchContact),
      act: (bloc) => bloc.add(ContactEvent.cancelSearchContact()),
      expect: () => [ const ContactState(
        state: StateStatus.showContactsLoad,
        listSearchResultContact: [],
        selectedGender: null
      )],
    );

  });

  group('mockDioResponse', () {
    const urlGetContactApi = 'https://658a7c8eba789a9622372698.mockapi.io/api/contact/users';
    final expectedResponseData = [{"createdAt":"2023-12-26T07:32:36.814Z","name":"Meghan Harvey","avatar":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/556.jpg","email":"Jabari_Feest22@example.org","numberPhone":"905-450-5654","gender":"Gender neutral","id":"1"}];
    const param = ContactParamEntity(limit: 1, page: 1);
    const paramSearch = ContactParamEntity(name: 'Meghan Harvey');

    test('get data', () async {
      dioAdapter.onGet(
        urlGetContactApi,
        (server) => server.reply(200, expectedResponseData),
        queryParameters: param.toJsonParam()
      );
    });

    test('search data', () async {
      dioAdapter.onGet(
        urlGetContactApi,
        (server) => server.reply(200, expectedResponseData),
        queryParameters: paramSearch.toJsonParamSearch()
      );
    });

  });

}