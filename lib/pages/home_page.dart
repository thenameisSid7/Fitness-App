import 'package:fitness_app/data/workout_data.dart';
import 'package:fitness_app/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum _MenuValues {
  edit,
  delete,
}

class _HomePageState extends State<HomePage> {
  final newWorkoutNameController = TextEditingController();
  final newExerciseNameController = TextEditingController();
  final newExerciseSetsController = TextEditingController();
  final newExerciseRepsController = TextEditingController();
  final newExerciseWeightController = TextEditingController();

  void createNewWorkout() {
    // dialog box to create new workout
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Create New Workout'),
              content: TextField(
                controller: newWorkoutNameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: save,
                  child: const Text('Save'),
                ),
              ],
            ));
  }
  // save the workout
  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    clear();
  }
  
  // cancel the dialog box and return to home page
  void cancel() {
    Navigator.pop(context);
    clear();
  }
  
  void clear() {
    newWorkoutNameController.clear();
  }

  void clearExercise() {
    newExerciseNameController.clear();
    newExerciseSetsController.clear();
    newExerciseRepsController.clear();
    newExerciseWeightController.clear();
  }

  void gotoWorkoutPage(int workoutIndex) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                  workoutIndex: workoutIndex,
                )));
  }
  // create a new exercise
  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add Exercise'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Name'
                    ),
                    controller: newExerciseNameController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Sets'
                    ),
                    controller: newExerciseSetsController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Weight'
                    ),
                    controller: newExerciseWeightController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Reps'
                    ),
                    controller: newExerciseRepsController,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearExercise();
                  },
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    Provider.of<WorkoutData>(context, listen: false)
                        .addExercise(
                            newExerciseNameController.text,
                            newExerciseSetsController.text,
                            newExerciseRepsController.text,
                            newExerciseWeightController.text);
                    Navigator.pop(context);
                    clearExercise();
                  },
                  child: const Text('Save'),
                ),
              ],
            ));
  }

  void _editWorkout(int workoutIndex) {
    // Get the current workout name
    String currentWorkoutName = Provider.of<WorkoutData>(context, listen: false)
        .workoutList[workoutIndex]
        .name;

    // Show the edit dialog
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Edit Workout'),
              content: TextField(
                controller: newWorkoutNameController..text=currentWorkoutName,
              ),
              actions: [
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    String newWorkoutName = newWorkoutNameController.text;
                    Provider.of<WorkoutData>(context, listen: false)
                        .editWorkout(workoutIndex, newWorkoutName);
                    Navigator.pop(context);
                    clear();
                  },
                  child: const Text('Save'),
                ),
              ],
            ));
  }

  void _deleteWorkout(int workoutIndex) {
    // Show the confirmation dialog
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text('Are you sure you want to delete this workout?'),
              actions: [
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    Provider.of<WorkoutData>(context, listen: false)
                        .deleteWorkout(workoutIndex);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
              ],
            ));
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        body: ListView.builder(
          itemCount: value.workoutList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(value.workoutList[index].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => gotoWorkoutPage(index),
                    icon: const Icon(Icons.arrow_forward_ios)),
                PopupMenuButton<_MenuValues>(
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: _MenuValues.edit,
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: _MenuValues.delete,
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case _MenuValues.edit:
                        _editWorkout(index);
                        break;
                      case _MenuValues.delete:
                        _deleteWorkout(index);
                        break;
                    }
                  },
                )
              ],
            ),
          ),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: createNewWorkout, child: const Text('Add Workout')),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: createNewExercise,
                child: const Text('Add Exercise')),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
