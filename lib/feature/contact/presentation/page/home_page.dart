import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_project/core/misc/app_color.dart';
import 'package:test_app_project/core/module/di/di_init_config.dart';
import 'package:test_app_project/feature/contact/presentation/bloc/contact_bloc.dart';
import 'package:test_app_project/feature/contact/presentation/page/detail_contact.dart';
import 'package:test_app_project/feature/contact/presentation/widget/app_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactBloc contactBloc = getIt<ContactBloc>();
  TextEditingController searchContactNameController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_actionScrollListener);
    searchContactNameController.addListener(_actionSearchContactListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _actionScrollListener() {
    if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
      if (contactBloc.state.listSearchResultContact.isEmpty) {
        contactBloc.add(ContactEvent.loadMoreContacts());
      }
    }
  }

  void _actionSearchContactListener() {
    if (searchContactNameController.text.isEmpty) {
      contactBloc.add(ContactEvent.cancelSearchContact());
    }
  }

  bool _isLoadState(ContactState state) =>
      state.state == StateStatus.errorLoad ||
      state.state == StateStatus.loading ||
      state.state == StateStatus.showContactsLoad ||
      state.state == StateStatus.loadingLoadMore ||
      state.state == StateStatus.successLoad;

  bool _isStateLoading(ContactState state) => 
      state.state == StateStatus.loading || 
      state.state == StateStatus.loadingSearch;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => contactBloc..add(ContactEvent.loadInitContacts()),
      child: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state.state == StateStatus.errorSearch || state.state == StateStatus.errorLoad) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorMassage}'),
              )
            );
          }
        },
        child: Builder(
          builder: (context) {
            final state = context.select((ContactBloc bloc) => bloc.state);
            final listContact = _isLoadState(state) 
              ? state.listContact 
              : state.listSearchResultContact;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'List Contact',
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchContactNameController,
                      decoration: InputDecoration(
                        label: const Text('Search by name'),
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchContactNameController.clear();
                            context.read<ContactBloc>().add(ContactEvent.cancelSearchContact());
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          context.read<ContactBloc>().add(
                              ContactEvent.searchContact(
                                  searchContactNameController.text));
                        }
                      },
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.all(6.0)
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.read<ContactBloc>().add(
                              ContactEvent.searchContact(
                                  searchContactNameController.text));
                        },
                        child: const Text(
                          'Cari',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _filterGenderWidget(state),
                    const SizedBox(height: 12),
                    _isStateLoading(state) ? const Center(child: CupertinoActivityIndicator(),) : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 14),
                        controller: scrollController,
                        itemCount: listContact.length,
                        itemBuilder: (context, index) {
                          if (index == (listContact.length - 1) && state.state == StateStatus.loadingLoadMore) {
                            return const CupertinoActivityIndicator();
                          }
                          return ItemAppWithImageWidget(
                            urlImg: '${listContact[index].avatar}',
                            title: '${listContact[index].name}',
                            phoneNumber: '${listContact[index].numberPhone}',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => DetailContactPage(
                                      contact: listContact[index])));
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _filterGenderWidget(ContactState state) {
    if (state.genders.isNotEmpty) {
      return SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Text('Filter by gender :'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: DropdownButton(
                    hint: const Text('Choose filter'),
                    value: state.selectedGender != null ? (state.selectedGender).toString() : null,
                    items: state.genders.map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    )).toList(), 
                    onChanged: (val) {
                      if (searchContactNameController.text.isNotEmpty) {
                        searchContactNameController.clear();
                      }
                      contactBloc.add(ContactEvent.searchGenderContact('$val'));
                    }
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    contactBloc.add(ContactEvent.cancelSearchContact());
                  },
                  child: SizedBox(
                    child: Icon(
                      CupertinoIcons.trash,
                      size: 20,
                      color: Colors.red.shade200,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return const CupertinoActivityIndicator();
    }
  }


}