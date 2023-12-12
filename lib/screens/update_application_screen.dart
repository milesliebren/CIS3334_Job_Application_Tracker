import 'package:flutter/material.dart';
import 'package:cis3334_job_application_tracker/models/job_application.dart';

class UpdateApplicationScreen extends StatefulWidget {
  final JobApplication application;
  final void Function(JobApplication) onUpdate;

  UpdateApplicationScreen({Key? key, required this.application, required this.onUpdate}) : super(key: key);

  @override
  _UpdateApplicationScreenState createState() => _UpdateApplicationScreenState();
}

class _UpdateApplicationScreenState extends State<UpdateApplicationScreen> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  String selectedStatus = ''; // Track the selected status

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    companyNameController.text = widget.application.companyName;
    positionController.text = widget.application.position;

    // Ensure that the initial status is one of the valid options
    selectedStatus = widget.application.status.isNotEmpty
        ? widget.application.status
        : ['Applied', 'Rejected', 'Pending', 'Interviewing', 'Accepted', 'Offered'][0];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Application'),
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
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedStatus,
              items: ['Applied', 'Rejected', 'Pending', 'Interviewing', 'Accepted', 'Offered'] // Add more statuses as needed
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement update functionality
                // Access the updated values from the text controllers
                String updatedCompanyName = companyNameController.text;
                String updatedPosition = positionController.text;

                // Create a new JobApplication with updated values
                JobApplication updatedApplication = JobApplication(
                  companyName: updatedCompanyName,
                  position: updatedPosition,
                  status: selectedStatus,
                );

                // TODO: Update the job application in your data storage (Hive, Firebase, etc.)
                // For example, if using Hive:
                widget.application
                  ..companyName = updatedCompanyName
                  ..position = updatedPosition
                  ..status = selectedStatus;

                widget.onUpdate(updatedApplication); // Notify the parent about the update

                // Close the update screen after updating
                Navigator.pop(context, updatedApplication); // Return the updated application to the previous screen
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}