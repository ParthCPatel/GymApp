import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final List<String> exercises = [
    "Barbell bench press",
    "Barbell bent-over row",
    "Barbell biceps curl",
    "Barbell shoulder press",
    "Chin-up",
    "Crunch",
    "Dumbbell bicep curls",
    "Dumbbell chest press",
    "Dumbbell shoulder press"
  ];

  final Map<String, TextEditingController> kgControllers = {};
  final Map<String, TextEditingController> repsControllers = {};

  @override
  void initState() {
    super.initState();
    for (var exercise in exercises) {
      kgControllers[exercise] = TextEditingController();
      repsControllers[exercise] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in kgControllers.values) {
      controller.dispose();
    }
    for (var controller in repsControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> saveWorkouts() async {
    final workoutsRef = FirebaseFirestore.instance.collection('workouts');
    List<Map<String, dynamic>> entries = [];

    for (var exercise in exercises) {
      final kg = kgControllers[exercise]!.text.trim();
      final reps = repsControllers[exercise]!.text.trim();

      if (kg.isNotEmpty && reps.isNotEmpty) {
        entries.add({
          "exercise": exercise,
          "kg": int.tryParse(kg) ?? 0,
          "reps": int.tryParse(reps) ?? 0,
          "completed": false,
          "timestamp": FieldValue.serverTimestamp(),
        });
      }
    }

    for (var entry in entries) {
      await workoutsRef.add(entry);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Workouts added!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      currentIndex: 1,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          title: const Text(
            'Add Workouts',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: exercises.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return Card(
              color: const Color(0xFF1E1E2C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: kgControllers[exercise],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                            decoration: InputDecoration(
                              labelText: 'Weight (kg)',
                              labelStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                              filled: true,
                              fillColor: const Color(0xFF2A2A40),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: repsControllers[exercise],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                            decoration: InputDecoration(
                              labelText: 'Reps',
                              labelStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                              filled: true,
                              fillColor: const Color(0xFF2A2A40),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: saveWorkouts,
          backgroundColor: const Color(0xFF00BFA5),
          icon: const Icon(Icons.save),
          label: const Text(
            'Save',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
