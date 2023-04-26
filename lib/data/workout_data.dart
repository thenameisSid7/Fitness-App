import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:flutter/material.dart';

// WorkoutData class contains all the methods of the home page 
class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(name: "Chest Workout", exercises: [
      Exercise(name: "Bench Press", sets: '4', reps: '10', weight: '100 kg'),
      Exercise(name: "Dumbbell Press", sets: '4', reps: '12', weight: '40 kg'),
      Exercise(name: "Pec-dec fly", sets: '4', reps: '12', weight: '60 kg'),
      Exercise(name: "Cable-Crossover", sets: '4', reps: '15', weight: '30 kg'),
    ]),
    Workout(name: "Back Workout", exercises: [
      Exercise(name: "Deadlift", sets: '4', reps: '6', weight: '200 kg'),
      Exercise(name: "Barbell Row", sets: '4', reps: '12', weight: '40 kg'),
      Exercise(name: "Dumbbell Row", sets: '4', reps: '12', weight: '40 kg'),
      Exercise(name: "Lat PullDown", sets: '4', reps: '12', weight: '50 kg'),
    ]),
  ];

  List<Exercise> exerciseList = [
    Exercise(name: "Bench Press", sets: '4', reps: '10', weight: '100 kg'),
    Exercise(name: "Dumbbell Press", sets: '4', reps: '12', weight: '40 kg'),
    Exercise(name: "Pec-dec fly", sets: '4', reps: '12', weight: '60 kg'),
    Exercise(name: "Cable-Crossover", sets: '4', reps: '15', weight: '30 kg'),
    Exercise(name: "Deadlift", sets: '4', reps: '6', weight: '200 kg'),
    Exercise(name: "Barbell Row", sets: '4', reps: '12', weight: '40 kg'),
    Exercise(name: "Dumbbell Row", sets: '4', reps: '12', weight: '40 kg'),
    Exercise(name: "Lat PullDown", sets: '4', reps: '12', weight: '50 kg'),
  ];
  //get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //length of a workout
  int numberOfExerciseInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  //add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  // add exercise from workout page
  void addExercise(String name, String sets, String reps, String weight) {
    exerciseList
        .add(Exercise(name: name, sets: sets, reps: reps, weight: weight));
  }

  // get a relevant workout
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  //add a Exercise to a workout
  void addExerciseToWorkout(int workoutIndex, Exercise exercise) {
    bool check = false;
    for (var element in workoutList[workoutIndex].exercises) {
      if (element.name == exercise.name) {
        check = true;
        continue;
      }
    }
    if (check) return;
    workoutList[workoutIndex].exercises.add(exercise);
    notifyListeners();
  }

  //delete exercise form Workout
  void deleteExerciseFromWorkout(String exerciseName, String workoutName) {
    Workout workout = getRelevantWorkout(workoutName);
    workout.exercises.removeWhere((exercise) => exercise.name == exerciseName);
    notifyListeners();
  }

  //check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  //get relevant exercise
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }

  // delete a workout
  void deleteWorkout(int workoutIndex) {
    workoutList.removeAt(workoutIndex);
    notifyListeners();
  }

// edit a workout
  void editWorkout(int workoutIndex, String newWorkoutName) {
    workoutList[workoutIndex].name = newWorkoutName;
    notifyListeners();
  }
}
