import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_themes.dart';
import 'core/widgets/loading_widget.dart';
import 'features/note/presentation/bloc/notes_bloc/note_bloc.dart';
import 'features/note/presentation/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          Timer(Duration(seconds: 2), () {
            if (state is LoadedNotesState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen()));
            }
          });
        },
        child: _buildSplashScreen(),
      ),
    );
  }

  Widget _buildSplashScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(child: Image.asset('assets/images/app-icon.png', width: 100)),
        LoadingWidget(
          color: primaryColor,
        )
      ],
    );
  }
}
