import 'package:flutter/material.dart';
import 'tips_details_view.dart';
import '../../common/color_extension.dart';
import '../../common_widget/tip_row.dart';

class TipsView extends StatefulWidget {
  const TipsView({super.key});

  @override
  State<TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<TipsView> {
  final List<Map<String, String>> tipsArr = [
    {"name": "About Training"},
    {"name": "How to weight loss?"},
    {"name": "Introducing meal plan"},
    {"name": "Water and Food"},
    {"name": "Drink water"},
    {"name": "How many times a day to eat"},
    {"name": "Become stronger"},
    {"name": "Shoes for Training"},
    {"name": "Appeal Tips"}
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/black_white.png",
            width: 25,
            height: 25,
          ),
        ),
        title: const Text(
          "Tips",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemBuilder: (context, index) {
          var tObj = tipsArr[index];
          return TipRow(
            tObj: tObj,
            isActive: index == 0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TipsDetailView(tObj: tObj),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black26,
            height: 1,
          );
        },
        itemCount: tipsArr.length,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavIcon("menu_running.png"),
              _buildNavIcon("menu_meal_plan.png"),
              _buildNavIcon("menu_home.png"),
              _buildNavIcon("menu_weight.png"),
              _buildNavIcon("more.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(String iconName) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        "assets/img/$iconName",
        width: 25,
        height: 25,
      ),
    );
  }
}
