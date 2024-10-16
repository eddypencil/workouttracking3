import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracking/models/blocs/cubit/StoreCubit/srore_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExerciseHistoryScreen extends StatelessWidget {
  const ExerciseHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var saveCubit = SaveCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise History"),
        backgroundColor: Colors.teal, // Optional: Set your preferred color
      ),
      body: BlocBuilder<SaveCubit, SroreState>(
        builder: (context, state) {
          if (state is LoadingGetExcersiceInfo) {
            // Show loading indicator while data is being fetched
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
            );
          } else if (state is SuccessGetExcersiceInfo) {
            // Show the list of workout sessions
            return ListView.builder(
              itemCount: saveCubit.workoutSession.length,
              itemBuilder: (context, index) {
                final workoutSession = saveCubit.workoutSession[index];

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 8, // Increased elevation for depth
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: ExpansionTile(
                      title: Text(
                        "Session ${index + 1}: ${DateFormat('yMMMd').format(workoutSession.startTime)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal,
                        ),
                      ),
                      subtitle: Text(
                        "Start: ${DateFormat('jm').format(workoutSession.startTime)} - End: ${DateFormat('jm').format(workoutSession.finishTime)}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      children: workoutSession.workoutData.map((workoutData) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8), // Rounded corners for the image
                            child: CachedNetworkImage(
                              imageUrl: workoutData.exercise.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                            ),
                          ),
                          title: Text(
                            workoutData.exercise.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "Muscles: ${workoutData.exercise.muscles.join(", ")}\n"
                                "Equipment: ${workoutData.exercise.equipment}\n"
                                "Weights: ${workoutData.weights.join(", ")}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: Text(
                            workoutData.exercise.difficulty,
                            style: const TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            );
          } else if (state is ErrorGetExcersiceInfo) {
            return Center(
              child: const Text("Error: No exercise history available."), // Changed to show error
            );
          }
          return const Center(child: Text("No exercise history available.")); // Handle the case when no state matches
        },
      ),
    );
  }
}
