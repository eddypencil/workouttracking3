import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../consts/Collections.dart';
import '../../../data/Local/SharedKeys.dart';
import '../../../data/Local/SharedPerfrence.dart';
import '../../../data/data.dart';

part 'srore_state.dart';

class SaveCubit extends Cubit<SroreState> {
  SaveCubit() : super(SroreInitial());

  static SaveCubit get(context) => BlocProvider.of(context);


  List<WorkoutSession> workoutSession = [];


  Future<void>setUserExcersiceInfo( {required String startDate , required String endDate , required List<WorkoutData> listWorkOuts } )async {
    emit(LoadingSetExcersiceInfo());
    await FirebaseFirestore.instance.collection(Collections.users).doc(LocalData.getData(key: SharedKey.uid)).collection("Excersice").add({
       "Start":startDate,
      "Ends":endDate,
      "WorkOutList": [
        for (var item in listWorkOuts)
          {
            "name": item.exercise.name,
             "muscles": item.exercise.muscles,
            "equipment": item.exercise.equipment,
            "id": item.exercise.id,
             "image": item.exercise.image,
            "weights": item.weights.toString(),

          }
      ]
      ,
    }).then((value){
    } );


  }

  // get user excersice
  Future<void> getUserExcersiceInfo() async {
    try {
      emit(LoadingGetExcersiceInfo());
      var userDoc = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(LocalData.getData(key: SharedKey.uid));

      var exerciseSnapshot = await userDoc.collection("Excersice").get();


      for (var doc in exerciseSnapshot.docs) {
        var docData = doc.data();
        List<WorkoutData> workoutData = [];

        for (var workoutItem in docData["WorkOutList"] ?? []) {
          workoutData.add(WorkoutData(
            exercise: Exercise(
              id: workoutItem["id"] != null ? workoutItem["id"] as int : 0, // default to 0
              name: workoutItem["name"] ?? "Unnamed Exercise",
              muscles: List<String>.from(workoutItem["muscles"] ?? []),
              equipment: workoutItem["equipment"] ?? "No equipment",
              image: workoutItem["image"] ?? "",
              instruction: "Default instruction", // Add actual instruction if available
              difficulty: "Basic", // Set default or modify as needed
            ),
            weights: List<String>.from((workoutItem["weights"] as String).split(',')), // Parse string to list
          ));
        }

        workoutSession.add(
          WorkoutSession(
            startTime: DateTime.tryParse(docData["Start"] ?? '') ?? DateTime.now(),
            finishTime: DateTime.tryParse(docData["Ends"] ?? '') ?? DateTime.now(),
            workoutData: workoutData,
          ),
        );
      }

      emit(SuccessGetExcersiceInfo(workoutSession));

      print("Workout Sessions: ${workoutSession[0].workoutData[0].exercise.name}");
    } catch (e) {
      emit(ErrorGetExcersiceInfo(e.toString()));
    }
  }

// Future<void>setUserExcersise()async {
  //   emit(LoadingSetShippingInfo());
  //   await FirebaseFirestore.instance.collection(Collection.users).doc(LocalData.getData(key: SharedKey.uid)).collection("ShippingInfo").add({
  //     "address" :address.text,
  //     "phoneNumber":phoneNumber.text,
  //     "title":title.text,
  //   }).then((value){
  //     selectedCardIndex = -1;
  //     emit(SuccessSetShippingInfo());
  //   } );
  //
  // }
}
