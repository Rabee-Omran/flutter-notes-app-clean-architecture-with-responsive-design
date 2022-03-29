import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required int id,
    required String title,
    required String description,
    required bool isFavorite,
    required bool isArchived,
    required List<String> imagesUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          isFavorite: isFavorite,
          isArchived: isArchived,
          imagesUrl: imagesUrl,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'isArchived': isArchived,
      'imagesUrl': imagesUrl,
    };
  }

  factory NoteModel.fromEntity(Note entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isFavorite: entity.isFavorite,
      isArchived: entity.isArchived,
      imagesUrl: entity.imagesUrl,
    );
  }

  factory NoteModel.fromJson(Map<String, Object> json) {
    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      isFavorite: json['isFavorite'] as bool,
      isArchived: json['isArchived'] as bool,
      imagesUrl: json['imagesUrl'] as List<String>,
    );
  }
}
