import 'package:equatable/equatable.dart';
import 'package:test/data/models/university.dart';

abstract class UniversitiesState extends Equatable {
  const UniversitiesState();

  @override
  List<Object?> get props => [];
}

class HomeEmpty extends UniversitiesState {}

class HomeLoading extends UniversitiesState {}

class HomeError extends UniversitiesState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeHasDataAsGrid extends UniversitiesState {
  final List<University> result;

  const HomeHasDataAsGrid(this.result);

  @override
  List<Object?> get props => [result];
}