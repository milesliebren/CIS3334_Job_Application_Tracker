import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cis3334_job_application_tracker/models/job_application.dart';

class AddApplicationScreen extends StatefulWidget {
  @override
  _AddApplicationScreenState createState() => _AddApplicationScreenState();
}

class _AddApplicationScreenState extends State<AddApplicationScreen> {
  late TextEditingController companyNameController;
  late TextEditingController positionController;

  @override
  void initState() {
    super.initState();
    companyNameController = TextEditingController();
    positionController = TextEditingController();
    // Initialize other controllers as needed
  }

  @override
  void dispose() {
    companyNameController.dispose();
    positionController.dispose();
    // Dispose of other controllers as needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Job Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: companyNameController,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            // Add other form fields as needed
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Create a new JobApplication instance with the entered data
                JobApplication newApplication = JobApplication(
                  companyName: companyNameController.text,
                  position: positionController.text,
                  status: 'Applied', // You can set a default status or provide a dropdown for the user
                  // Add other fields as needed
                );

                // Save the newApplication to Hive
                await saveApplicationToHive(newApplication);

                // Navigate back to the HomeScreen
                Navigator.pop(context);
              },
              child: Text('Add Application'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> saveApplicationToHive(JobApplication application) async {
  final Box<JobApplication> jobApplicationsBox = Hive.box<JobApplication>('jobApplications');

  // Open the box if it's not open yet
  if (!jobApplicationsBox.isOpen) {
    await Hive.openBox<JobApplication>('jobApplications');
  }

  // Add the new application to Hive
  jobApplicationsBox.add(application);
}