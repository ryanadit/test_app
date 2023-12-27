import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app_project/core/extensions/dartz_extension.dart';
import 'package:test_app_project/feature/contact/data/models/contact_model.dart';
import 'package:test_app_project/feature/contact/domain/entity/contact_entity.dart';
import 'package:test_app_project/feature/contact/domain/usecase/get_contact_usecase.dart';
import 'package:test_app_project/feature/contact/domain/usecase/search_contact_usecase.dart';

part 'contact_event.dart';
part 'contact_state.dart';
part 'contact_bloc.freezed.dart';

@injectable
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final GetContactsUsecase _getContactsUsecase;
  final SearchContactsUsecase _searchContactsUsecase;

  ContactBloc(
    this._getContactsUsecase,
    this._searchContactsUsecase
  ) : super(ContactState.initial()) {
    on<_LoadInitContacts>(_onLoadContacts);
    on<_SearchContacts>(_onSearchContacts);
    on<_LoadMoreContacts>(_onLoadMoreContacts);
    on<_CancelSearchContact>(_onCancelSearch);
    on<_SearchGenderContacts>(_onSearchGenderContact);
  }

  int limitCountPage = 20;
  int pageCountMax = 5; // -> 100 / 20 = 5
  int maxLoadCount = 15; // -> 300 / 20 = 15

  FutureOr<void> _onLoadContacts(_LoadInitContacts event, Emitter emit) async {
    emit(state.copyWith(state: StateStatus.loading));
    
    final result = await _getContactsUsecase.call(ContactParamEntity(
      page: 1,
      limit: limitCountPage,
    ));

    if (result.isRight()) {
      List<String> listGender = _addGenderToList(state: state, data: result.getRight() ?? []);
      emit(
        state.copyWith(
          state: StateStatus.successLoad,
          listContact: result.getRight() ?? [],
          genders: listGender
        )
      );
    } else {
      emit(
        state.copyWith(
          state: StateStatus.errorLoad,
          errorMassage: result.getLeft()?.errorResponse
        )
      );
    }

  }

  FutureOr<void> _onSearchContacts(_SearchContacts event, Emitter emit) async {
    emit(state.copyWith(state: StateStatus.loadingSearch, selectedGender: null));

    final result = await _searchContactsUsecase.call(ContactParamEntity(name: event.name));

    if (result.isRight()) {
      emit(
        state.copyWith(
          state: StateStatus.successSearch,
          listSearchResultContact: result.getRight() ?? [],
        )
      );
    } else {
      emit(
        state.copyWith(
          state: StateStatus.errorSearch,
          errorMassage: result.getLeft()?.errorResponse,
          listSearchResultContact: [],
        )
      );
    }
  }

  FutureOr<void> _onLoadMoreContacts(_LoadMoreContacts event, Emitter emit) async {
    emit(state.copyWith(state: StateStatus.loadingLoadMore));
    int page = state.page + 1;
    int loadCount = state.loadCount + 1;

    if (page > pageCountMax) {
      page = 1;
    }

    if (loadCount > maxLoadCount) {
      emit(state.copyWith(
        errorMassage: 'Max load is 300 contacts',
        state: StateStatus.errorLoad,
      ));
    } else {
      emit(state.copyWith(page: page, loadCount: loadCount));

      final result = await _getContactsUsecase.call(ContactParamEntity(
        page: page,
        limit: limitCountPage,
      ));

      if (result.isRight()) {
        List<ContactModel> resultContacts = result.getRight() ?? [];
        List<ContactModel> currentStateContacts = state.listContact;
        if (resultContacts.isNotEmpty) {
          currentStateContacts += resultContacts;
        }
        List<String> listGender =
            _addGenderToList(state: state, data: result.getRight() ?? []);
        emit(state.copyWith(
            state: StateStatus.successLoad,
            listContact: currentStateContacts,
            genders: listGender));
      } else {
        emit(state.copyWith(
            state: StateStatus.errorLoad,
            errorMassage: result.getLeft()?.errorResponse));
      }
    }
  }

  FutureOr<void> _onSearchGenderContact(
      _SearchGenderContacts event, Emitter emit) async {
    emit(state.copyWith(state: StateStatus.loadingSearch));
    try {
      List<ContactModel> currentContacts = state.listContact;
      List<ContactModel> resultSearch = [];
      if (currentContacts.isNotEmpty) {
        resultSearch = currentContacts
            .where((contact) =>
                (contact.gender ?? '').toLowerCase() ==
                event.gender.toLowerCase())
            .toList();
      }

      emit(state.copyWith(
          state: StateStatus.successSearch,
          listSearchResultContact: resultSearch,
          selectedGender: event.gender));
    } catch (error) {
      emit(state.copyWith(
          state: StateStatus.errorSearch, errorMassage: '$error'));
    }

  }

  Future<void> _onCancelSearch(_CancelSearchContact event, Emitter emit) async {
    // reset result search
    emit(state.copyWith(
      state: StateStatus.showContactsLoad,
      listSearchResultContact: [],
      selectedGender: null
    ));
  }

  List<String> _addGenderToList({ required ContactState state, List<ContactModel> data = const []}) {
    List<String> listGender = [];
    if (state.genders.isNotEmpty) {
      for (String gender in state.genders) {
        listGender.add(gender);
      }
    }
    if (data.isNotEmpty) {
      for (ContactModel contact in data) {
        if (!listGender.contains(contact.gender)) {
          listGender.add(contact.gender ?? '');
        } 
      }
    }
    return listGender;
  }

}
