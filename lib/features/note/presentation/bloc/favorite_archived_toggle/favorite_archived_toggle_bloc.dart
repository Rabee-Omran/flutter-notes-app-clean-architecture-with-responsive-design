import 'package:bloc/bloc.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/usecases/toggle_note_archived.dart';
import '../../../domain/usecases/toggle_note_favorite.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/note.dart';

part 'favorite_archived_toggle_event.dart';
part 'favorite_archived_toggle_state.dart';

class FavoriteArchivedToggleBloc
    extends Bloc<FavoriteArchivedToggleEvent, FavoriteArchivedToggleState> {
  final ToggleNoteFavoriteUsecase toggleFavorite;
  final ToggleNoteArchivedUsecase toggleArchived;

  FavoriteArchivedToggleBloc(
      {required this.toggleFavorite, required this.toggleArchived})
      : super(FavoriteArchivedToggleInitial()) {
    on<FavoriteArchivedToggleEvent>((event, emit) async {
      if (event is FavoriteToggleEvent) {
        emit(FavoriteToggleLoadingState());
        final failureOrDone = await toggleFavorite(event.note);
        emit(_eitherFailureOrDone(either: failureOrDone));
      } else if (event is ArchivedToggleEvent) {
        emit(ArchivedToggleLoadingState());
        final failureOrDone = await toggleArchived(event.note);
        emit(_eitherFailureOrDone(either: failureOrDone));
      }
    });
  }
  FavoriteArchivedToggleState _eitherFailureOrDone(
      {required Either<Failure, void> either}) {
    return either.fold(
      (failure) => FavoriteArchivedToggleErrorState(
          message: _mapFailureToMessage(failure)),
      (_) => FavoriteArchivedToggleMessageState(message: DONE_SUSCESS_MESSAGE),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;

      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
