import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:workout_tracking/models/data/data.dart';
import '../../common/color_extension.dart';
import '../../common_widget/response_row.dart';

class WorkoutDetailView extends StatelessWidget {
  final Exercise exercise;
  WorkoutDetailView({super.key, required this.exercise});

  final List<Map<String, String>> responseArr = [
    {
      "name": "Mikhail Eduardovich",
      "time": "09 days ago",
      "image": "assets/img/u2.png",
      "message": "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
    },
    {
      "name": "Mikhail Eduardovich",
      "time": "11 days ago",
      "image": "assets/img/u1.png",
      "message": "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
    },
    {
      "name": "Mikhail Eduardovich",
      "time": "12 days ago",
      "image": "assets/img/u2.png",
      "message": "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
    },
    {
      "name": "Mikhail Eduardovich",
      "time": "13 days ago",
      "image": "assets/img/u1.png",
      "message": "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
    },
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
          overflow: TextOverflow.ellipsis,
          exercise.name,
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: exercise.image,
              width: media.width,
              height: media.width * 0.55,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: TColor.primary,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/img/like.png",
                        width: 20, height: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/img/share.png",
                        width: 20, height: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Instructions",style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(exercise.instruction,
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "17 Responses",
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shrinkWrap: true,
              itemCount: responseArr.length,
              itemBuilder: (context, index) {
                var rObj = responseArr[index];
                return ResponsesRow(rObj: rObj);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_running.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_meal_plan.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_home.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_weight.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child:
                    Image.asset("assets/img/more.png", width: 25, height: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
