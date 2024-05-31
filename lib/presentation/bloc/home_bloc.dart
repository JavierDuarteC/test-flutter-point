import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/data/models/university.dart';
import 'package:test/domain/usecases/universities_usecase.dart';
import 'package:test/presentation/bloc/home_event.dart';
import 'package:test/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<UniversitiesEvent, UniversitiesState> {
  final UniversitiesUseCase _homeUseCase;

  List<University> _movies = [];

  HomeBloc(this._homeUseCase) : super(HomeEmpty()) {
    on<OnLoad>(
      (event, emit) async {
        emit(HomeLoading());

        final result = await _homeUseCase.executeGetUniversities();
        result.fold(
          (failure) {
            emit(HomeError(failure.message));
          },
          (data) {
            _movies = data;
            emit(HomeHasDataAsGrid(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
