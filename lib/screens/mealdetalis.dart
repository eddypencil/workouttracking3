import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracking/common/color_extension.dart';
import 'package:workout_tracking/models/data/data.dart';

class MealDetailView extends StatelessWidget {
  final Meal meal;

  const MealDetailView({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Keeping the background white
      appBar: AppBar(
        title: Text(
          meal.name,
          style: GoogleFonts.quicksand(color: Colors.black), // Dark text for the app bar
        ),
        backgroundColor: TColor.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: meal.image_url,
              child: Image.network(
                meal.image_url,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black), // Dark loading indicator
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200], // Light grey for the error placeholder
                    height: 250,
                    width: double.infinity,
                    child: const Icon(
                      Icons.error,
                      color: Colors.black, // Dark icon for better visibility
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                meal.name,
                style: GoogleFonts.quicksand(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Dark text for the meal name
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Calories: ${meal.calories}',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.black87, // Slightly lighter black for calories
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Ingredients: ${meal.ingredients.join(', ')}', // Assuming Meal has a list of ingredients
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  color: Colors.black54, // Dark grey for ingredients
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Instructions: ${meal.instructions}', // Assuming Meal has instructions
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  color: Colors.black54, // Dark grey for instructions
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
