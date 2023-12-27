part of 'contact_bloc.dart';

@freezed 
class ContactEvent with _$ContactEvent {
  factory ContactEvent.loadInitContacts() = _LoadInitContacts;
  factory ContactEvent.loadMoreContacts() = _LoadMoreContacts;
  factory ContactEvent.searchContact(String name) = _SearchContacts;
  factory ContactEvent.cancelSearchContact() = _CancelSearchContact;
  factory ContactEvent.searchGenderContact(String gender) = _SearchGenderContacts;
}