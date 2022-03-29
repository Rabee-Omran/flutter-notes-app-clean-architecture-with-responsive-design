import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_themes.dart';
import '../../../../core/responsive.dart';
import '../../../../core/util/border_extensions.dart';
import '../../domain/entities/note.dart';
import '../bloc/selected_note_bloc/selected_note_bloc.dart';
import '../pages/note_page.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    this.isActive = true,
    required this.note,
  }) : super(key: key);

  final bool? isActive;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: () {
          !Responsive.isMobile(context)
              ? BlocProvider.of<SelectedNoteBloc>(context)
                  .add(ChangeSelectedNote(note))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailPage(note: note),
                  ),
                );
        },
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: isActive! && !Responsive.isMobile(context)
                ? primaryColor
                : kBgDarkColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildCircularAvatar(context),
                  SizedBox(width: kDefaultPadding / 2),
                  _buildTitle(context),
                ],
              ),
              SizedBox(height: kDefaultPadding / 2),
              _buildDescription(context)
            ],
          ),
        ).addNeumorphism(
          blurRadius: 15,
          borderRadius: 15,
          offset: Offset(5, 5),
          topShadowColor: Colors.white60,
          bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
        ),
      ),
    );
  }

  Text _buildDescription(BuildContext context) {
    return Text(
      note.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption!.copyWith(
            height: 1.5,
            color: isActive! && !Responsive.isMobile(context)
                ? Colors.white70
                : null,
          ),
    );
  }

  SizedBox _buildCircularAvatar(BuildContext context) {
    return SizedBox(
      width: 32,
      child: CircleAvatar(
        backgroundColor: isActive! && !Responsive.isMobile(context)
            ? kBgDarkColor
            : primaryColor.withOpacity(0.5),
        child: Center(
          child: Text(
            note.title.substring(0, 1),
            style: TextStyle(
              color: isActive! && !Responsive.isMobile(context)
                  ? primaryColor
                  : kBgDarkColor,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildTitle(BuildContext context) {
    return Expanded(
      child: Text(
        note.title,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.5,
              color: isActive! && !Responsive.isMobile(context)
                  ? Colors.white70
                  : Colors.black.withOpacity(.7),
            ),
      ),
    );
  }
}
