part of 'favorite_archived_toggle_bloc.dart';

abstract class FavoriteArchivedToggleEvent extends Equatable {
  const FavoriteArchivedToggleEvent();

  @override
  List<Object> get props => [];
}

class FavoriteToggleEvent extends FavoriteArchivedToggleEvent {
  final Note note;

  FavoriteToggleEvent(this.note);

  @override
  List<Object> get props => [note];
}

class ArchivedToggleEvent extends FavoriteArchivedToggleEvent {
  final Note note;

  ArchivedToggleEvent(this.note);

  @override
  List<Object> get props => [note];
}
