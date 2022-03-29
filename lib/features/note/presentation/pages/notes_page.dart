import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../../core/app_themes.dart';
import '../../domain/entities/note.dart';
import '../bloc/add_edit_delete_note/add_edit_delete_note_bloc.dart';
import '../bloc/notes_bloc/note_bloc.dart';
import '../bloc/selected_note_bloc/selected_note_bloc.dart';
import '../widgets/side_menu.dart';

import '../../../../core/responsive.dart';
import '../widgets/note_card.dart';
import 'add_edit_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    Key? key,
  }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: SideMenu(),
        ),
        body: BlocListener<AddEditDeleteNoteBloc, AddEditDeleteNoteState>(
          listener: (context, state) async {
            await Future.delayed(Duration(milliseconds: 200), () {
              if (state is AddEditDelErrorState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              } else if (state is AddEditDelMessageState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
            color: kBgDarkColor,
            child: SafeArea(
              right: false,
              child: Column(
                children: [
                  _buildHeader(context),
                  SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: BlocBuilder<NoteBloc, NoteState>(
                      builder: (context, state) {
                        if (state is LoadedNotesState) {
                          final notes = state.notes;
                          return _buildNotesList(state, notes);
                        }
                        return LoadingWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Responsive.isMobile(context)
            ? FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => AddEditPage(
                              isEditing: false,
                              isDialog: false,
                            )),
                  );
                },
                child: Icon(Icons.add),
              )
            : SizedBox());
  }

  ListView _buildNotesList(LoadedNotesState state, List<Note> notes) {
    return ListView.builder(
      itemCount: state.notes.length,
      itemBuilder: (context, index) => BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          return BlocBuilder<SelectedNoteBloc, SelectedNoteState>(
            builder: (context, selectedNoteState) {
              return NoteCard(
                note: notes[index],
                isActive: isCurrentNoteSelected(
                        selectedState: selectedNoteState, note: notes[index])
                    ? true
                    : false,
              );
            },
          );
        },
      ),
    );
  }

  bool isCurrentNoteSelected(
      {required SelectedNoteState selectedState, required Note note}) {
    if (selectedState is LoadedNoteState) {
      if (selectedState.note.id == note.id) {
        return true;
      }
    }
    return false;
  }

  Padding _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          if (!Responsive.isDesktop(context)) SizedBox(width: 5),
          Expanded(
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: "Search",
                fillColor: kBgLightColor,
                filled: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 0.75), //15
                  child: WebsafeSvg.asset(
                    "assets/icons/Search.svg",
                    width: 24,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
