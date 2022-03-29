// ignore_for_file: unused_field, invalid_use_of_visible_for_testing_member

import 'package:clean_arcitecture_responsive_ui/features/note/domain/entities/note.dart';
import 'package:clean_arcitecture_responsive_ui/features/note/presentation/bloc/add_edit_delete_note/add_edit_delete_note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_themes.dart';
import '../../../../core/responsive.dart';

class AddEditPage extends StatefulWidget {
  final bool isEditing;
  final Note? note;
  final bool isDialog;

  AddEditPage({
    Key? key,
    required this.isEditing,
    this.note,
    required this.isDialog,
  }) : super(key: key);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize:
                        widget.isDialog ? MainAxisSize.min : MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          if (widget.isDialog)
                            Row(
                              children: [
                                CloseButton(),
                                SizedBox(width: 5),
                                Text(
                                    widget.isEditing ? "Edit Note" : "Add Note",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black))
                              ],
                            )
                          else if (Responsive.isMobile(context))
                            Row(
                              children: [
                                BackButton(),
                                SizedBox(width: 5),
                                Text("Add Note",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black))
                              ],
                            ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _buildTitleInput(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildDescriptionInput(),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:
                    BlocConsumer<AddEditDeleteNoteBloc, AddEditDeleteNoteState>(
                  listener: (context, state) async {
                    if (state is AddEditDelMessageState) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is AddEditDelLoadingState) {
                      return CircularProgressIndicator(
                        color: primaryColor,
                      );
                    }
                    return _buildAddEditButton(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildAddEditButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            widget.isEditing
                ? BlocProvider.of<AddEditDeleteNoteBloc>(context)
                    .add(UpdateNoteEvent(Note.empty()))
                : BlocProvider.of<AddEditDeleteNoteBloc>(context)
                    .add(AddNoteEvent(Note.empty()));
          }
        },
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)))),
        child: Text(
          isEditing ? "Update" : "Add",
        ),
      ),
    );
  }

  TextFormField _buildDescriptionInput() {
    return TextFormField(
      initialValue: isEditing ? widget.note!.description : '',
      maxLines: 10,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.description_outlined),
        hintText: "Description",
      ),
      onSaved: (value) => _description = value!,
      // validator: (val) {
      //   return val!.trim().isEmpty ? "Please Enter note description" : null;
      // },
    );
  }

  Widget _buildTitleInput() {
    return TextFormField(
      initialValue: isEditing ? widget.note!.title : '',
      autofocus: !isEditing,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.title),
        hintText: "Title",
      ),
      // validator: (val) {
      //   return val!.trim().isEmpty ? "Please Enter some note title" : null;
      // },
      onSaved: (value) => _title = value!,
    );
  }
}
