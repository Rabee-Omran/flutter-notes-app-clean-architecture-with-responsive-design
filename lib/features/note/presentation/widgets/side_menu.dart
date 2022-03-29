import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../../core/app_themes.dart';

import '../../../../core/util/border_extensions.dart';
import '../../../../core/responsive.dart';
import '../bloc/notes_bloc/note_bloc.dart';
import '../pages/add_edit_page.dart';
import 'side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/app-icon.png",
                        width: 46,
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      Text(
                        "Notes",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Spacer(),
                      if (!Responsive.isDesktop(context)) CloseButton(),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding),
                  if (!Responsive.isMobile(context))
                    _buildAddButton(context).addNeumorphism(
                      topShadowColor: Colors.white,
                      bottomShadowColor: Color(0xFF234395).withOpacity(0.2),
                    ),
                  SizedBox(height: kDefaultPadding * 2),
                  SideMenuItem(
                    press: () {
                      if (Responsive.isMobile(context)) Navigator.pop(context);

                      BlocProvider.of<NoteBloc>(context)
                          .add(GetAllNotesEvent());
                    },
                    title: "All",
                    icon: Icons.all_inbox,
                    isActive:
                        isMenuItemActive(state, NotesType.All) ? true : false,
                  ),
                  SideMenuItem(
                    press: () {
                      if (Responsive.isMobile(context)) Navigator.pop(context);

                      BlocProvider.of<NoteBloc>(context)
                          .add(GetFavoriteNotes());
                    },
                    title: "Favorite",
                    icon: Icons.favorite,
                    isActive: isMenuItemActive(state, NotesType.Favorite)
                        ? true
                        : false,
                  ),
                  SideMenuItem(
                    press: () {
                      if (Responsive.isMobile(context) ||
                          Responsive.isTablet(context)) Navigator.pop(context);

                      BlocProvider.of<NoteBloc>(context)
                          .add(GetArchivedNotes());
                    },
                    title: "Archived",
                    icon: Icons.archive_outlined,
                    isActive: isMenuItemActive(state, NotesType.Archived)
                        ? true
                        : false,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool isMenuItemActive(NoteState state, NotesType type) {
    if (state is LoadedNotesState) {
      if (state.type == type) return true;
    }
    return false;
  }

  ElevatedButton _buildAddButton(context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding,
        ),
      ),
      onPressed: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 50.0,
                  ),
                  content: Container(
                    width: 1000,
                    child: AddEditPage(
                      isEditing: false,
                      isDialog: true,
                    ),
                  ));
            });
      },
      icon: WebsafeSvg.asset("assets/icons/Edit.svg", width: 16),
      label: Text(
        "New Note",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
