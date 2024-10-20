import 'package:flutter/material.dart';
import '../../common/color_extension.dart';

class TipsDetailView extends StatefulWidget {
  final Map<String, dynamic> tObj;
  const TipsDetailView({super.key, required this.tObj});

  @override
  _TipsDetailViewState createState() => _TipsDetailViewState();
}

class _TipsDetailViewState extends State<TipsDetailView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            "assets/img/black_white.png",
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          "Tips",
          style: TextStyle(
            color: TColor.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/img/1.png",
              width: media.width,
              height: media.width * 0.55,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  widget.tObj["name"],
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildSectionTitle("Drink water"),
            _buildSectionContent(
              "To enhance your fitness journey, aim to drink plenty of water throughout the day by setting a daily intake goal based on your weight and activity level. Drink a glass of water before meals to aid digestion and keep hydrated during workouts by sipping water every 15-20 minutes. Monitor your urine color as a hydration indicator; pale yellow is ideal. Carry a reusable water bottle for convenience, and consider adding natural flavors like lemon or cucumber to make water more enjoyable. Lastly, listen to your body and increase your water intake in hot weather or during intense exercise, as proper hydration significantly impacts performance and recovery."
            ),
            _buildSectionTitle("Calories"),
            _buildSectionContent(
              "To effectively manage your fitness goals, understanding calories is crucial. Track your daily caloric intake based on your personal energy needs, which can vary depending on factors like age, weight, and activity level. Focus on the quality of calories by prioritizing nutrient-dense foods, such as fruits, vegetables, whole grains, and lean proteins, over empty calories found in processed foods. Consider using a food diary or app to help monitor your intake and make adjustments as needed. Additionally, remember that balancing the calories you consume with those you burn through exercise is key for weight management, whether you're looking to lose, maintain, or gain weight.",
            ),
          ],
        ),
      ),
      
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: TColor.secondaryText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        content,
        style: TextStyle(color: TColor.secondaryText, fontSize: 16),
      ),
    );
  }

  List<Widget> _buildBottomNavigationItems() {
    List<String> icons = [
      "menu_running.png",
      "menu_meal_plan.png",
      "menu_home.png",
      "menu_weight.png",
      "more.png"
    ];

    return icons
        .map((icon) => InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/img/$icon",
                width: 25,
                height: 25,
              ),
            ))
        .toList();
  }
}
