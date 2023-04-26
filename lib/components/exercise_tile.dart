import 'package:fitness_app/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

// Shows the number of sets, reps and weight of every exercise 
class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String sets;
  final String reps;
  final String weight;
  final bool isCompleted;
  final String workoutName;
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.sets,
      required this.reps,
      required this.weight,
      required this.isCompleted,
      required this.onCheckBoxChanged,
      required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Slidable(
        endActionPane: ActionPane(motion: const BehindMotion(), children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              Provider.of<WorkoutData>(context, listen: false)
                  .deleteExerciseFromWorkout(exerciseName, workoutName);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          )
        ]),
        child: ListTile(
          title: Text(
            exerciseName,
          ),
          subtitle: Row(
            children: [
              Chip(label: Text(weight)),
              Chip(label: Text('$sets sets')),
              Chip(label: Text('$reps reps')),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                  value: isCompleted,
                  onChanged: (value) => onCheckBoxChanged!(value)),
            ],
          ),
        ),
      ),
    );
  }
}
