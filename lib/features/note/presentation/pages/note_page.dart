import '../../../../core/responsive.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_themes.dart';
import '../../domain/entities/note.dart';
import '../widgets/header.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;
  const NoteDetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Header(note: note),
            Divider(thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: kDefaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: kDefaultPadding),
                          LayoutBuilder(
                            builder: (context, constraints) => SizedBox(
                              width: constraints.maxWidth > 850
                                  ? 1400
                                  : constraints.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              note.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: kDefaultPadding / 2),
                                      Text(
                                        "Today at 15:32",
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: kDefaultPadding),
                                  Text(
                                    note.description,
                                    style: TextStyle(
                                      height: 1.5,
                                      color: Color(0xFF4D5875),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(height: kDefaultPadding),
                                  _buildImages(context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  GridView _buildImages(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: note.imagesUrl.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          note.imagesUrl[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

getCrossAxisCount(BuildContext context) {
  if (Responsive.isMobile(context)) return 2;
  if (Responsive.isTablet(context)) return 3;
  if (Responsive.isDesktop(context)) return 4;
}
