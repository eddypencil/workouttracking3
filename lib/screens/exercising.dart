import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracking/common/color_extension.dart';
import 'package:workout_tracking/models/blocs/cubit/AuthCubit/auth_cubit.dart';
import 'package:workout_tracking/models/blocs/cubit/StoreCubit/srore_cubit.dart';
import 'package:workout_tracking/models/data/data.dart';
import 'package:workout_tracking/models/blocs/cubit/workoutcubit.dart';
import 'package:workout_tracking/view/menu/menu_view.dart';

class WorkoutSessionScreen extends StatefulWidget {
  const WorkoutSessionScreen({super.key});

  @override
  _WorkoutSessionScreenState createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  int currentExerciseIndex = 0;
  late List<WorkoutData> workoutDataList;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workoutDataList = context.read<ExerciseCubit>().workout;
  }

  void _nextExercise() {
    setState(() {
      if (currentExerciseIndex < workoutDataList.length - 1) {
        currentExerciseIndex++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No more exercises!')),
        );
      }
    });
  }

  void _done() {
    DateTime finishTime = DateTime.now();

    WorkoutSession workoutSession = WorkoutSession(
      startTime: startTime,
      finishTime: finishTime,
      workoutData: workoutDataList,
    );

    SaveCubit().setUserExcersiceInfo(endDate: workoutSession.finishTime.toString(), startDate: workoutSession.startTime.toString(), listWorkOuts: workoutSession.workoutData.toList());


    print('Workout Session Created:');
    print('Start Time: $startTime');
    print('Finish Time: $finishTime');
    print('Workout Data: ${workoutDataList.length} exercises');

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BlocProvider(
  create: (context) => AuthCubit()..getUserInfoFire(),
  child: MenuView(),
)));

    // clear the workout data
    context.read<ExerciseCubit>().workout.clear();


  }

  @override
  Widget build(BuildContext context) {
    if (workoutDataList.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Workout Session')),
        body: Center(child: Text('No exercises added.')),
      );
    }

    final currentExercise = workoutDataList[currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        title: Text('Workout Session'),
        actions: [
          if (currentExerciseIndex < workoutDataList.length - 1)
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: _nextExercise,
            ),
          if (currentExerciseIndex == workoutDataList.length - 1)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _done,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(currentExercise.exercise.image),
            Text(
              currentExercise.exercise.name,
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Instructions: ${currentExercise.exercise.instruction}',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Weights:',
              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var weight in currentExercise.weights)
              Text(weight, style: GoogleFonts.roboto(fontSize: 24)),
            const SizedBox(height: 20),
            TimerWidget(),
          ],
        ),
      ),
    );
  }
}




class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _secondsRemaining = 30;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _secondsRemaining = 30;
    });

    _startCountdown(); // Start the countdown
  }

  Future<void> _startCountdown() async {
    while (_secondsRemaining > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        return; // Exit if widget is disposed
      }
    }

    if (mounted) {
      setState(() {
        _isRunning = false; // Timer finished
      });
    }
  }

  void _resetTimer() {
    // No need to call setState here, just reset local state
    _secondsRemaining = 30;
    _isRunning = false;
  }

  @override
  void dispose() {
    _resetTimer(); // Just reset the local state without calling setState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Timer: $_secondsRemaining',
          style: GoogleFonts.roboto(fontSize: 20),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _startTimer,
          child: Text(
            'Start Timer',
            style: TextStyle(color: TColor.primary),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _resetTimer();
            _startTimer(); // Restart the timer
          },
          child: Text(
            'Reset Timer',
            style: TextStyle(color: TColor.primary),
          ),
        ),
      ],
    );
  }
}
