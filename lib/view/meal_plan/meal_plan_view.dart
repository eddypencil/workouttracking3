import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracking/common/color_extension.dart';
import 'package:workout_tracking/consts/colors.dart';
import 'package:workout_tracking/models/blocs/cubit/mealcubit.dart';
import 'package:workout_tracking/models/data/data.dart';
import 'package:workout_tracking/models/repos/data_repo.dart';
import 'package:workout_tracking/screens/mealdetalis.dart';

class MealPlanView2 extends StatelessWidget {
  const MealPlanView2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealCubit(DataRepo())..fetchMeals(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Recommended Meals"),backgroundColor: TColor.primary,),
        body: BlocBuilder<MealCubit, MealState>(
          builder: (context, state) {
            return state.when(
              loading: () => CircularProgressIndicator.adaptive(),
              loaded: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => MealCard(meal: data[index]),
                );
              },
              error: (message) => Text("error"),
            );
          },
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailView(meal: meal),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
                
                child: Image.network(
                  meal.image_url,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey, // Grey placeholder
                      height: 200,
                      width: double.infinity,
                      child: const Icon(
                        Icons.error, // Optional error icon
                        color: Colors.white,
                        size: 50, // Adjust size as needed
                      ),
                    );
                  },
                  // Optionally, you can use a loading builder
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                    ),
                    Text(
                      'Calories',
                      style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      meal.calories.toString(),
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Text(meal.name,overflow: TextOverflow.ellipsis, // Handling text overflow
                                          style: TextStyle(
                                              color: TColor.secondaryText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),)
          ],
        )
      ),
    );
  }
}
