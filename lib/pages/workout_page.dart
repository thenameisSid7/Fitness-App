import 'package:fitness_app/components/exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/workout_data.dart';
import '../models/exercise.dart';

class WorkoutPage extends StatefulWidget {
  final int workoutIndex;
  const WorkoutPage({required this.workoutIndex, super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  void _openExerciseDialog(List<Exercise> exerciseList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Exercise',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300, // Set a maximum height to prevent overflow
          ),
          child: SingleChildScrollView(
            child: ListBody(
              children: exerciseList
                  .map((exercise) => ListTile(
                        title: Text(exercise.name),
                        onTap: () {
                          Provider.of<WorkoutData>(context, listen: false)
                              .addExerciseToWorkout(
                                  widget.workoutIndex, exercise);
                          Navigator.pop(context);
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(value.workoutList[widget.workoutIndex].name),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _openExerciseDialog(value.exerciseList),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: value.numberOfExerciseInWorkout(
                value.workoutList[widget.workoutIndex].name),
            itemBuilder: (context, index) => ExerciseTile(
                exerciseName: value
                    .getRelevantWorkout(
                        value.workoutList[widget.workoutIndex].name)
                    .exercises[index]
                    .name,
                sets: value
                    .getRelevantWorkout(
                        value.workoutList[widget.workoutIndex].name)
                    .exercises[index]
                    .sets,
                reps: value
                    .getRelevantWorkout(
                        value.workoutList[widget.workoutIndex].name)
                    .exercises[index]
                    .reps,
                weight: value
                    .getRelevantWorkout(
                        value.workoutList[widget.workoutIndex].name)
                    .exercises[index]
                    .weight,
                isCompleted: value
                    .getRelevantWorkout(
                        value.workoutList[widget.workoutIndex].name)
                    .exercises[index]
                    .isCompleted,
                onCheckBoxChanged: (val) => onCheckBoxChanged(
                    value.workoutList[widget.workoutIndex].name,
                    value
                        .getRelevantWorkout(
                            value.workoutList[widget.workoutIndex].name)
                        .exercises[index]
                        .name),
                workoutName: value.workoutList[widget.workoutIndex].name),
          )),
    );
  }
}
