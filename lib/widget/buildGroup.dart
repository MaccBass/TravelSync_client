import 'package:flutter/material.dart';
import 'package:travelsync_client/widgets/header.dart';

class BuildGroup extends StatefulWidget {
  const BuildGroup({super.key});

  @override
  State<BuildGroup> createState() => BuildGroupState();
}

class BuildGroupState extends State<BuildGroup> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController agencyController = TextEditingController();

  void createGroup() {
    // Implement your group creation logic here
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              textHeader: "Build Group",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: groupNameController,
                decoration: const InputDecoration(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: countryController,
                decoration: const InputDecoration(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: agencyController,
                decoration: const InputDecoration(),
              ),
            ),
            ElevatedButton(
              onPressed: createGroup,
              child: const Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
