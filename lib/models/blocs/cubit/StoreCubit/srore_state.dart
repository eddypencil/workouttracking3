part of 'srore_cubit.dart';

@immutable
abstract class SroreState {}

class SroreInitial extends SroreState {}

// for excersice

class LoadingSetExcersiceInfo extends SroreState {}


class SuccessSetExcersiceInfo extends SroreState {}


class ErrorSetExcersiceInfo extends SroreState {
  final String message;
  ErrorSetExcersiceInfo(this.message);
}

// for get excersice


class LoadingGetExcersiceInfo extends SroreState {}

// success get excersice

class SuccessGetExcersiceInfo extends SroreState {
  final List<WorkoutSession> workoutSession;
  SuccessGetExcersiceInfo(this.workoutSession);
}

// error get excersice
class ErrorGetExcersiceInfo extends SroreState {
  final String message;
  ErrorGetExcersiceInfo(this.message);
}


