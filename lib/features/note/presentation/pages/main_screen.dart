import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/responsive.dart';
import '../bloc/selected_note_bloc/selected_note_bloc.dart';
import '../widgets/side_menu.dart';
import 'note_page.dart';
import 'notes_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocBuilder<SelectedNoteBloc, SelectedNoteState>(
      builder: (context, state) {
        return Scaffold(
          body: Responsive(
            mobile: NotesPage(),
            tablet: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: NotesPage(),
                ),
                if (state is LoadedNoteState)
                  Expanded(
                    flex: 9,
                    child: NoteDetailPage(
                      note: state.note,
                    ),
                  ),
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  flex: getMenuFlex(state, _size.width),
                  child: SideMenu(),
                ),
                Expanded(
                  flex: _size.width > 1340 ? 3 : 5,
                  child: NotesPage(),
                ),
                if (state is LoadedNoteState)
                  Expanded(
                    flex: _size.width > 1340 ? 8 : 10,
                    child: NoteDetailPage(
                      note: state.note,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

int getMenuFlex(SelectedNoteState state, double width) {
  if (state is LoadedNoteState && width > 1090) {
    return 4;
  } else if (state is LoadedNoteState) {
    return 2;
  }

  return 1;
}
