import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PreAssessmentScreen(),
  ));
}

// Pre-Assessment Screen
class PreAssessmentScreen extends StatefulWidget {
  @override
  _PreAssessmentScreenState createState() => _PreAssessmentScreenState();
}

class _PreAssessmentScreenState extends State<PreAssessmentScreen> {
  PageController _pageController = PageController();
  TextEditingController _ageController = TextEditingController();

  // Data for the questions and answers
  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is your gender?',
      'options': ['Male', 'Female', 'Other'],
    },
    {
      'question': 'How old are you?',
      'options': ['Select Age'],
    },
    {
      'question': 'How often do you work out?',
      'options': ['Daily', '3-4 times a week', 'Once a week', 'Not at all'],
    },
    {
      'question': 'What is your main fitness goal?',
      'options': ['Build Muscle', 'Lose Weight', 'Improve Stamina', 'General Fitness'],
    },
    {
      'question': 'Do you have any injuries or health concerns?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'What equipment do you have?',
      'options': ['Select Equipment'],
    },
  ];

  String selectedGender = '';
  String selectedAge = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pre-Assessment'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fitness Logo
            Center(
              child: Icon(
                Icons.fitness_center,
                color: Colors.black,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            // Title
            Text(
              "Pre-Assessment",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Answer these quick questions to get a personalized fitness plan.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            // PageView for Questions
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(
                    questions[index]['question'],
                    questions[index]['options'],
                    index,
                    context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(String question, List<String> options, int questionIndex, BuildContext context) {
    if (questionIndex == 1) { // Age input (picker)
      return Card(
        color: Colors.grey[200],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedAge = (index + 18).toString(); // Start from age 18 to 100
                    });
                    // Automatically move to the next question after age is selected
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  children: List<Widget>.generate(83, (index) {
                    return Center(
                      child: Text(
                        (index + 18).toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 8),
              Text(
                selectedAge.isNotEmpty ? "Selected Age: $selectedAge" : "Please select your age",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    } else if (questionIndex == 5) { // Navigate to equipment selection screen
      return Card(
        color: Colors.grey[200],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Navigate to the Equipment Selection Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EquipmentSelectionScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                  ),
                  child: Text(
                    "Select Equipment",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Regular options for other questions
      return Card(
        color: Colors.grey[200],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(height: 8),
              ...options.map((option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () {
                    // Go to the next question when an option is selected
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                    ),
                    child: Text(option, style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
      );
    }
  }
}

// Equipment Selection Screen (unchanged)
class EquipmentSelectionScreen extends StatefulWidget {
  @override
  _EquipmentSelectionScreenState createState() => _EquipmentSelectionScreenState();
}

class _EquipmentSelectionScreenState extends State<EquipmentSelectionScreen> {
  List<Map<String, dynamic>> equipmentOptions = [
    {'name': 'Dumbbells', 'symbol': '🏋️‍♂️'},
    {'name': 'Resistance Bands', 'symbol': '💪'},
    {'name': 'Yoga Mat', 'symbol': '🧘‍♀️'},
    {'name': 'Kettlebell', 'symbol': '🏋️‍♀️'},
    {'name': 'None', 'symbol': '❌'},
  ];

  List<String> selectedEquipment = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Equipment'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose the equipment you have access to:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: equipmentOptions.length,
                itemBuilder: (context, index) {
                  final equipment = equipmentOptions[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedEquipment.contains(equipment['name'])) {
                          selectedEquipment.remove(equipment['name']);
                        } else {
                          selectedEquipment.add(equipment['name']);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedEquipment.contains(equipment['name'])
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 32,
                            color: Colors.black,
                          ),
                          SizedBox(height: 8),
                          Text(
                            equipment['name'],
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the selection and move to the next screen or save
                Navigator.pop(context);
              },
              child: Text('Confirm Selection'),
            ),
          ],
        ),
      ),
    );
  }
}
