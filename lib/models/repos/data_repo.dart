import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:workout_tracking/models/data/data.dart';

class DataRepo {

Future<List<Exercise>> getExercises () async{
  try{
  String jsonString = await rootBundle.loadString('assets/json/exercises.json');
  List<dynamic> exerciseJson = json.decode(jsonString);
  List<Exercise> exercises = exerciseJson.map((exerciseJson) => Exercise.fromJson(exerciseJson)).toList() ;
  print(exercises.toString());
  return exercises;
  }catch (e){
    print(e);
    return [];
  }

}
}


