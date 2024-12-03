import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WorkoutGeneratorScreen(),
  ));
}

class WorkoutGeneratorScreen extends StatefulWidget {
  @override
  _WorkoutGeneratorScreenState createState() => _WorkoutGeneratorScreenState();
}

class _WorkoutGeneratorScreenState extends State<WorkoutGeneratorScreen> {
  String selectedWorkoutType = 'Strength Training';
  String selectedDifficulty = 'Intermediate';
  double workoutDuration = 30; // Default duration: 30 minutes

  List<String> workoutTypes = ['Strength Training', 'Cardio', 'Flexibility', 'Endurance'];
  List<String> difficultyLevels = ['Beginner', 'Intermediate', 'Advanced'];

  String generatedWorkout = '';

  // Function to generate workout based on selections
  void generateWorkout() {
    setState(() {
      generatedWorkout = generateWorkoutPlan(selectedWorkoutType, selectedDifficulty, workoutDuration);
    });
  }

  // Function to suggest exercises based on selections
  String generateWorkoutPlan(String workoutType, String difficulty, double duration) {
    List<String> workoutSuggestions = [];

    // Strength Training
    if (workoutType == 'Strength Training') {
      if (difficulty == 'Beginner') {
        workoutSuggestions = ['Bodyweight Squats: 3 sets of 10', 'Push-ups: 3 sets of 8', 'Plank: 3 sets of 30 seconds'];
      } else if (difficulty == 'Intermediate') {
        workoutSuggestions = ['Dumbbell Squats: 4 sets of 12', 'Push-ups: 4 sets of 15', 'Plank with leg lift: 3 sets of 1 minute'];
      } else if (difficulty == 'Advanced') {
        workoutSuggestions = ['Barbell Squats: 5 sets of 5', 'Pull-ups: 4 sets of 10', 'Weighted Plank: 3 sets of 1.5 minutes'];
      }
    }

    // Cardio
    else if (workoutType == 'Cardio') {
      if (difficulty == 'Beginner') {
        workoutSuggestions = ['Jogging: 20 minutes', 'Jump Rope: 5 minutes', 'High Knees: 3 sets of 1 minute'];
      } else if (difficulty == 'Intermediate') {
        workoutSuggestions = ['Running: 30 minutes', 'Jump Rope: 10 minutes', 'Burpees: 4 sets of 15'];
      } else if (difficulty == 'Advanced') {
        workoutSuggestions = ['HIIT: 30 minutes', 'Burpees: 5 sets of 20', 'Sprints: 10 x 30 seconds'];
      }
    }

    // Flexibility
    else if (workoutType == 'Flexibility') {
      workoutSuggestions = ['Hamstring Stretch: 3 sets of 30 seconds', 'Cobra Stretch: 3 sets of 1 minute', 'Quadriceps Stretch: 3 sets of 30 seconds'];
    }

    // Endurance
    else if (workoutType == 'Endurance') {
      if (difficulty == 'Beginner') {
        workoutSuggestions = ['Walking: 30 minutes', 'Cycling: 30 minutes', 'Bodyweight Circuits: 3 rounds of 10 reps'];
      } else if (difficulty == 'Intermediate') {
        workoutSuggestions = ['Jogging: 45 minutes', 'Cycling: 45 minutes', 'HIIT: 4 rounds of 15 reps'];
      } else if (difficulty == 'Advanced') {
        workoutSuggestions = ['Running: 60 minutes', 'HIIT: 5 rounds of 20 reps', 'Cycling: 60 minutes'];
      }
    }

    // Display the workout suggestions based on duration
    return 'Workout Plan:\n- Type: $workoutType\n- Difficulty: $difficulty\n- Duration: ${duration.toInt()} minutes\n\nExercises:\n${workoutSuggestions.join("\n")}\n\nEnjoy your workout!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Your Workout'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Customize Your Workout",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Dropdown for workout type
            Text("Select Workout Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            DropdownButton<String>(
              value: selectedWorkoutType,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedWorkoutType = newValue!;
                });
              },
              items: workoutTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Dropdown for difficulty level
            Text("Select Difficulty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            DropdownButton<String>(
              value: selectedDifficulty,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDifficulty = newValue!;
                });
              },
              items: difficultyLevels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Slider for workout duration
            Text("Select Duration (minutes)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Slider(
              value: workoutDuration,
              min: 15,
              max: 90,
              divisions: 15,
              label: workoutDuration.toInt().toString(),
              onChanged: (double newValue) {
                setState(() {
                  workoutDuration = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            // Button to generate workout
            Center(
              child: ElevatedButton(
                onPressed: generateWorkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Generate Workout', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(height: 30),
            // Display the generated workout plan
            if (generatedWorkout.isNotEmpty)
              Card(
                color: Colors.grey[200],
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    generatedWorkout,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
