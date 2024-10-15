import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'data.freezed.dart'; // Add this line
part 'data.g.dart';       // This line might already be present

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required int id,
    required String name,
    required List<String> muscles,
    required String instruction,
    required String equipment,
    required String difficulty,
    required String image,

  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    required String name,
    required DateTime time,
    required List<Exercise> exercises,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}



class WorkoutData {
  final Exercise exercise;
  final List<String> weights;

  WorkoutData({
    required this.exercise,
    required this.weights,
  });
}


class WorkoutSession {
  final DateTime startTime;
  final DateTime finishTime;
  final List<WorkoutData> workoutData;

  WorkoutSession({
    required this.startTime,
    required this.finishTime,
    required this.workoutData,
  });
}
