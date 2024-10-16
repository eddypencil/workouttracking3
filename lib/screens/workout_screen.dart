import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracking/models/blocs/cubit/workoutcubit.dart';
import 'package:workout_tracking/models/repos/data_repo.dart';
import 'package:workout_tracking/screens/presets.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

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
    return BlocProvider(
      create: (_) => ExerciseCubit(DataRepo())..fetchdata(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Exercises',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MuscleTabs(muscles: muscles),
                BlocBuilder<ExerciseCubit, ExerciseState>(
                  builder: (context, state) {
                    return state.when(
                      error: (message) => const Center(
                          child: Text("sorry there have been an error")),
                      loading: () => const CircularProgressIndicator(),
                      loaded: (data) => Flexible(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.9,
                          child: ListView.builder(
                              shrinkWrap: true,
                              
                              itemBuilder: (context, index) {
                                return ExerciseTile(exercise: data[index]);
                              },
                              itemCount: data.length,
                            ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}

class MuscleTabs extends StatelessWidget {
  const MuscleTabs({
    super.key,
    required this.muscles,
  });

  final List<String> muscles;

  @override
  Widget build(BuildContext context) {
   final selectedIndex=  context.watch<ExerciseCubit>().selectedIndex;
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CatagoriesBar(
            name: muscles[index],
            index: index,
            isSelected: index== selectedIndex,
          );
        },
        itemCount: muscles.length,
      ),
    );
  }
}

class CatagoriesBar extends StatelessWidget {
  final String name;
  final int index;
  final bool isSelected;
  const CatagoriesBar({super.key, required this.name, required this.index,  required this.isSelected});

  @override
  Widget build(BuildContext context) {
     
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
         context.read<ExerciseCubit>().setSelectedIndex(index);

        },
        child: Chip(
          label: Text(name),
          backgroundColor: isSelected? Colors.blueGrey[900] : Colors.blueGrey ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelStyle:const  TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //
          ),
        ),
      ),
    );
  }
}


