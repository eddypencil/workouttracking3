import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracking/models/blocs/cubit/workoutcubit.dart';
import 'package:workout_tracking/models/repos/data_repo.dart';
import 'package:workout_tracking/view/workout/workout_detail_view.dart';

import '../../common/color_extension.dart';


class ExerciseView2 extends StatefulWidget {
  const ExerciseView2({super.key});

  @override
  State<ExerciseView2> createState() => _ExerciseView2State();
}

class _ExerciseView2State extends State<ExerciseView2> {
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: TColor.primary,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/img/black_white.png",
                  width: 25,
                  height: 25,
                )),
            title: Text(
              "Exercise",
              style: TextStyle(
                  color: TColor.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: state.when(
            loading: () => CircularProgressIndicator.adaptive(),
            loaded: (data) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                MuscleTabs(muscles: muscles),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: TColor.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkoutDetailView(
                                          exercise: data[index])));
                            },
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: data[index].image,
                                      width: media.width,
                                      height: media.width * 0.55,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: media.width,
                                      height: media.width * 0.55,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                    Image.asset(
                                      "assets/img/play.png",
                                      width: 60,
                                      height: 60,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: TColor.secondaryText,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WorkoutDetailView(
                                                            exercise:
                                                                data[index])));
                                          },
                                          icon: Image.asset(
                                              "assets/img/more.png",
                                              width: 25,
                                              height: 25))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ]),
            ),
            error: (message) => Center(child: Text("Error")),
          ),
          
        );
      },
    );
  }
}

class CatagoriesBar extends StatelessWidget {
  final String name;
  final int index;
  final bool isSelected;
  const CatagoriesBar(
      {super.key, required this.name, required this.index, required this.isSelected});

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
          backgroundColor: isSelected ? Color(0xff388e3c) : Color(0xfff4caf50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
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
    final selectedIndex = context.watch<ExerciseCubit>().selectedIndex;
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CatagoriesBar(
            name: muscles[index],
            index: index,
            isSelected: index == selectedIndex,
          );
        },
        itemCount: muscles.length,
      ),
    );
  }
}
