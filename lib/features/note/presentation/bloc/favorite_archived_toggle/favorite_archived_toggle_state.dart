part of 'favorite_archived_toggle_bloc.dart';

abstract class FavoriteArchivedToggleState extends Equatable {
  const FavoriteArchivedToggleState();

  @override
  List<Object> get props => [];
}

class FavoriteArchivedToggleInitial extends FavoriteArchivedToggleState {}

class ArchivedToggleLoadingState extends FavoriteArchivedToggleState {}

class FavoriteToggleLoadingState extends FavoriteArchivedToggleState {}

class FavoriteArchivedToggleErrorState extends FavoriteArchivedToggleState {
  final String message;

  const FavoriteArchivedToggleErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteArchivedToggleMessageState extends FavoriteArchivedToggleState {
  final String message;

  const FavoriteArchivedToggleMessageState({required this.message});

  @override
  List<Object> get props => [message];
}
