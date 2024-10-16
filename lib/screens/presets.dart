import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracking/common/color_extension.dart';
import 'package:workout_tracking/models/blocs/cubit/workoutcubit.dart';
import 'package:workout_tracking/models/data/data.dart';
import 'package:workout_tracking/screens/exercising.dart';
import 'package:workout_tracking/screens/workout_screen.dart';

class WorkoutPicker extends StatelessWidget {
  const WorkoutPicker({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> muscles = [
    'All',
    'Chest',
    'Triceps',
    'Shoulders',
    'Lats',
    'Upper Chest',
    'Back',
    'Biceps',
    'Traps',
    'Legs',
    'Gluteus',
    'Lower Back',
    'Core',
    'Full Body',
    'Cardio',
  ];

    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        return state.when(
          loading: () => CircularProgressIndicator(),
          loaded: (data) => Scaffold(
            appBar: AppBar(
              title: Text(
                "PICK YOUR WORKOUT",
                style: GoogleFonts.roboto(),
              ),
              backgroundColor: TColor.primary,
            ),
            body: Column(
              children: [
                MuscleTabs(muscles: muscles),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length, 
                    itemBuilder: (context, index) {
                      return ExerciseTile(exercise: data[index]);
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkoutSessionScreen(),));
              },
              backgroundColor: TColor.primary,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(FontAwesomeIcons.play), // Play icon
                
                  
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Center the button at the bottom
          ),
          error: (message) => Text("error"),
        );
      },
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: TColor.primary,
          backgroundImage: NetworkImage(exercise.image),
          radius: 28,
        ),
        title: Text(
          exercise.name,
          style: GoogleFonts.roboto(fontSize: 18),
        ),
        trailing: Container(
          decoration:  BoxDecoration(shape: BoxShape.circle,color: TColor.primary),
          child: IconButton(onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ModelSheet(exercise: exercise),
              );
            
          }, icon: const Icon(FontAwesomeIcons.plus,color: Colors.white,)),
        ),
      ),
    );
  }
}


class ModelSheet extends StatefulWidget {
  final Exercise exercise; // Ensure this is passed to the widget

  const ModelSheet({super.key, required this.exercise});

  @override
  _ModelSheetState createState() => _ModelSheetState();
}

class _ModelSheetState extends State<ModelSheet> {
  final List<TextEditingController> weightControllers = [];

  @override
  void initState() {
    super.initState();
    _addNewRow(); // Initialize with one row
  }

  @override
  void dispose() {
    for (var controller in weightControllers) {
      controller.dispose(); // Dispose the controllers when the widget is disposed
    }
    super.dispose();
  }

  void _addNewRow() {
    TextEditingController controller = TextEditingController();
    controller.addListener(_updateButtonState);
    weightControllers.add(controller);
  }

  void _updateButtonState() {
    setState(() {}); 
  }

  void _removeRow(int index) {
    if (weightControllers.length > 1) {
      setState(() {
        weightControllers[index].dispose(); // Dispose the controller being removed
        weightControllers.removeAt(index);
      });
    }
  }

  bool _hasEmptyFields() {
    for (var controller in weightControllers) {
      if (controller.text.isEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add sets for ${widget.exercise.name}",
            style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: weightControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: weightControllers[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Weight ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () => _removeRow(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _hasEmptyFields()
                    ? null
                    : () {
                        List<String> weights =
                            weightControllers.map((controller) => controller.text).toList();
                        context.read<ExerciseCubit>().addWorkoutData(
                              WorkoutData(exercise: widget.exercise, weights: weights),
                            );
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasEmptyFields() ? Colors.grey : TColor.primary,
                ),
                child: Text('Add Exercise'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _addNewRow(); // Add a new row
                  });
                },
                child: Text('Add One More Row'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}