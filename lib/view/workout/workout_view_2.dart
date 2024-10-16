import 'package:flutter/material.dart';
import '../../common/color_extension.dart';

class WorkoutView2 extends StatefulWidget {
  const WorkoutView2({super.key});

  @override
  State<WorkoutView2> createState() => _WorkoutView2State();
}

class _WorkoutView2State extends State<WorkoutView2> {
  final List<Map<String, String>> workArr = [
    {"name": "Push-Up", "image": "assets/img/1.png"},
    {"name": "Leg Extension", "image": "assets/img/2.png"},
    {"name": "Squat", "image": "assets/img/5.png"},
    {"name": "Climber", "image": "assets/img/3.png"},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon:
              Image.asset("assets/img/black_white.png", width: 25, height: 25),
        ),
        title: Text(
          "Workout",
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: workArr.length,
        itemBuilder: (context, index) {
          var wObj = workArr[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), 
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        wObj["image"]!,
                        width: media.width,
                        height: media.width * 0.55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: media.width,
                      height: media.width * 0.55,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(15)),
                      ),
                    ),
                    Image.asset("assets/img/play.png", width: 60, height: 60),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        wObj["name"]!,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
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
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavIcon("assets/img/menu_running.png"),
              _buildBottomNavIcon("assets/img/menu_meal_plan.png"),
              _buildBottomNavIcon("assets/img/menu_home.png"),
              _buildBottomNavIcon("assets/img/menu_weight.png"),
              _buildBottomNavIcon("assets/img/more.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavIcon(String assetPath) {
    return InkWell(
      onTap: () {
      },
      child: Image.asset(assetPath, width: 25, height: 25),
    );
  }
}
