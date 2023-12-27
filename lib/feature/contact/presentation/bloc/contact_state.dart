part of 'contact_bloc.dart';

enum StateStatus { 
  initial, 
  loading, 
  errorLoad, 
  showContactsLoad,
  successLoad, 
  errorSearch, 
  successSearch, 
  loadingSearch,
  loadingLoadMore
}

@Freezed(makeCollectionsUnmodifiable: false)
class ContactState with _$ContactState {
  const factory ContactState({
    @Default(StateStatus.initial) StateStatus state,
    @Default([]) List<ContactModel> listContact,
    @Default([]) List<ContactModel> listSearchResultContact,
    @Default([]) List<String> genders,
    String? errorMassage,
    String? successMessage,
    @Default(1) int page,
    @Default(1) int loadCount,
    String? selectedGender,
  }) = _ContactState;

  factory ContactState.initial() => const ContactState();
}
