import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../../core/app_themes.dart';
import '../../../../core/responsive.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../domain/entities/note.dart';
import '../bloc/add_edit_delete_note/add_edit_delete_note_bloc.dart';
import '../bloc/favorite_archived_toggle/favorite_archived_toggle_bloc.dart';
import '../bloc/selected_note_bloc/selected_note_bloc.dart';
import '../pages/add_edit_page.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          if (Responsive.isMobile(context))
            BackButton()
          else
            CloseButton(onPressed: () {
              BlocProvider.of<SelectedNoteBloc>(context)
                  .add(InitialSelectedEvent());
              if (!Responsive.isMobile(context) &&
                  Navigator.of(context).canPop()) Navigator.pop(context);
            }),
          Spacer(),
          _buildDeleteConsumer(),
          _buildEditConsumer(context),
          _buildFavoriteConsumer(),
          _buildArchivedConsumer(),
        ],
      ),
    );
  }

  Widget _buildArchivedConsumer() {
    return BlocConsumer<FavoriteArchivedToggleBloc,
        FavoriteArchivedToggleState>(
      listener: (context, state) async {
        await Future.delayed(Duration(milliseconds: 200), () {
          if (state is FavoriteArchivedToggleErrorState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          } else if (state is FavoriteArchivedToggleMessageState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
          }
        });
      },
      builder: (context, state) {
        if (state is ArchivedToggleLoadingState) {
          return _buildLoading();
        }
        return IconButton(
          icon: WebsafeSvg.asset("assets/icons/Markup.svg",
              width: 24,
              color: note.isFavorite ? Colors.yellow[600] : Colors.grey),
          onPressed: () {
            BlocProvider.of<FavoriteArchivedToggleBloc>(context)
                .add(ArchivedToggleEvent(note));
          },
        );
      },
    );
  }

  Widget _buildFavoriteConsumer() {
    return BlocConsumer<FavoriteArchivedToggleBloc,
        FavoriteArchivedToggleState>(
      listener: (context, state) async {
        await Future.delayed(Duration(milliseconds: 200), () {
          if (state is FavoriteArchivedToggleErrorState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          } else if (state is FavoriteArchivedToggleMessageState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
          }
        });
      },
      builder: (context, state) {
        if (state is FavoriteToggleLoadingState) {
          return _buildLoading();
        }
        return IconButton(
          icon: Icon(
            note.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: Colors.redAccent,
          ),
          onPressed: () {
            BlocProvider.of<FavoriteArchivedToggleBloc>(context)
                .add(FavoriteToggleEvent(note));
          },
        );
      },
    );
  }

  Widget _buildEditConsumer(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: Colors.greenAccent,
      ),
      onPressed: () async {
        if (!Responsive.isMobile(context)) {
          return await showDialog(
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
                        isEditing: true,
                        isDialog: Responsive.isMobile(context) ? false : true,
                        note: note,
                      ),
                    ));
              });
        }

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => AddEditPage(
                    isEditing: true,
                    isDialog: Responsive.isMobile(context) ? false : true,
                    note: note,
                  )),
        );
      },
    );
  }

  Widget _buildDeleteConsumer() {
    return BlocConsumer<AddEditDeleteNoteBloc, AddEditDeleteNoteState>(
      listener: (context, state) async {
        if (state is AddEditDelMessageState) {
          if (Responsive.isMobile(context)) Navigator.of(context).pop();
          BlocProvider.of<SelectedNoteBloc>(context)
              .add(InitialSelectedEvent());
        }
      },
      builder: (context, state) {
        if (state is AddEditDelLoadingState) {
          return _buildLoading();
        }
        return _buildDeleteButton(context);
      },
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: WebsafeSvg.asset(
        "assets/icons/Trash.svg",
        width: 24,
      ),
      onPressed: () {
        _buildDeleteDialog(context);
      },
    );
  }

  AwesomeDialog _buildDeleteDialog(BuildContext context) {
    return AwesomeDialog(
      width: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width / 2,
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: "Are you sure ?",
      desc: note.title,
      btnCancel: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      btnOk: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<AddEditDeleteNoteBloc>(context)
                .add(DeleteNoteEvent(note));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Text(
            "Yes",
          ),
        ),
      ),
    )..show();
  }

  Widget _buildLoading() {
    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.symmetric(horizontal: 14),
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }
}
