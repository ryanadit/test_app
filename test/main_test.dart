import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_project/feature/contact/presentation/bloc/contact_bloc.dart';


class MockContactBloc extends MockBloc<ContactEvent, ContactState> implements ContactBloc {}

void main() {
  mainContactBloc();

}

void mainContactBloc() {
  group('fetch contact', () {
    final bloc = MockContactBloc();
  });
}