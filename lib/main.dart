import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_themes.dart';
import 'features/note/presentation/bloc/add_edit_delete_note/add_edit_delete_note_bloc.dart';
import 'features/note/presentation/bloc/favorite_archived_toggle/favorite_archived_toggle_bloc.dart';
import 'features/note/presentation/bloc/notes_bloc/note_bloc.dart';
import 'features/note/presentation/bloc/selected_note_bloc/selected_note_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NoteBloc>()..add(GetAllNotesEvent())),
        BlocProvider(create: (_) => sl<SelectedNoteBloc>()),
        BlocProvider(create: (_) => sl<AddEditDeleteNoteBloc>()),
        BlocProvider(create: (_) => sl<FavoriteArchivedToggleBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        theme: appTheme,
        home: SplashScreen(),
      ),
    );
  }
}
