import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool isFavorite;
  final bool isArchived;
  final List<String> imagesUrl;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.isArchived,
    required this.imagesUrl,
  });

  factory Note.empty() {
    return Note(
      id: 0,
      title: "",
      description: "",
      isFavorite: false,
      isArchived: false,
      imagesUrl: [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isFavorite,
        isArchived,
        imagesUrl,
      ];
}
