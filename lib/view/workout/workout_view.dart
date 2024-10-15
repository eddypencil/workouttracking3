import 'package:flutter/material.dart';
import 'package:workout_tracking/common/color_extension.dart';
import 'package:workout_tracking/view/workout/workout_detail_view.dart';
import '../../common_widget/round_button.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  final List<Map<String, String>> workArr = [
    {
      "name": "Climber",
      "image": "assets/img/1.png",
      "title": "Workout",
      "subtitle": "Personalized workouts will help\nyou gain strength"
    },
    {
      "name": "Climber",
      "image": "assets/img/2.png",
      "title": "Workout",
      "subtitle": "Personalized workouts will help\nyou gain strength"
    },
    {
      "name": "Climber",
      "image": "assets/img/5.png",
      "title": "Workout",
      "subtitle": "Personalized workouts will help\nyou gain strength"
    },
    {
      "name": "Climber",
      "image": "assets/img/3.png",
      "title": "Workout",
      "subtitle": "Personalized workouts will help\nyou gain strength"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: TColor.textColor),
        ),
        title: Text(
          "Workout",
          style: TextStyle(
            color: TColor.textColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        itemCount: workArr.length,
        itemBuilder: (context, index) {
          var wObj = workArr[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: media.width * 0.55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Image.asset(
                  wObj["image"]!,
                  width: media.width,
                  height: media.width * 0.55,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: media.width,
                  height: media.width * 0.55,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wObj["name"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        wObj["subtitle"]!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 110,
                          height: 35,
                          child: RoundButton(
                            title: "See More",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            onPressed: () {
                            
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: TColor.background,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Icon(Icons.directions_run,
                    size: 28, color: TColor.textColor),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.fastfood, size: 28, color: TColor.textColor),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.home, size: 28, color: TColor.textColor),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.fitness_center,
                    size: 28, color: TColor.textColor),
              ),
              InkWell(
                onTap: () {},
                child:
                    Icon(Icons.more_horiz, size: 28, color: TColor.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
