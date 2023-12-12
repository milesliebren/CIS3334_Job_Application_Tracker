import 'package:flutter/material.dart';
import 'package:cis3334_job_application_tracker/models/job_application.dart';
import 'package:cis3334_job_application_tracker/screens/update_application_screen.dart';

class ApplicationDetailsScreen extends StatefulWidget {
  final JobApplication application;
  final Function onDelete;
  final void Function(JobApplication) onUpdate; // Explicitly define the type of onUpdate

  ApplicationDetailsScreen({Key? key, required this.application, required this.onDelete, required this.onUpdate}) : super(key: key);

  @override
  _ApplicationDetailsScreenState createState() => _ApplicationDetailsScreenState();
}

class _ApplicationDetailsScreenState extends State<ApplicationDetailsScreen> {
  String selectedStatus = ''; // Track the selected status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Name: ${widget.application.companyName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Position: ${widget.application.position}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${widget.application.status}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(context, 'Delete Application?', 'Are you sure you want to delete this application?', () {
                      // TODO: Implement delete functionality
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateApplicationScreen(application: widget.application, onUpdate: widget.onUpdate),
                      ),
                    );
                  },
                  child: Text('Update'),
                ),
                // Remove the "Change Status" button
              ],
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _showConfirmationDialog(BuildContext context, String title, String content, VoidCallback onConfirm) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                widget.onDelete(); // Notify the parent about deletion
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

}
