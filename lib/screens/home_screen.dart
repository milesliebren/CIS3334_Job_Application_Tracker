import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cis3334_job_application_tracker/screens/application_details_screen.dart';
import 'package:cis3334_job_application_tracker/models/job_application.dart';
import 'package:cis3334_job_application_tracker/screens/add_application_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<JobApplication> jobApplicationsBox;

  @override
  void initState() {
    super.initState();
    openHiveBox();
  }

  Future<void> openHiveBox() async {
    await Hive.openBox<JobApplication>('jobApplications');
    jobApplicationsBox = Hive.box<JobApplication>('jobApplications');
    if (jobApplicationsBox.isEmpty) {
      await addSampleJobApplications();
    }
    setState(() {});
  }

  Future<void> addSampleJobApplications() async {
    await jobApplicationsBox.add(JobApplication(
      companyName: 'Sample Company 1',
      position: 'Software Engineer',
      status: 'Applied',
    ));

    await jobApplicationsBox.add(JobApplication(
      companyName: 'Sample Company 2',
      position: 'Product Manager',
      status: 'Interviewing',
    ));

    await jobApplicationsBox.add(JobApplication(
      companyName: 'Sample Company 3',
      position: 'Data Analyst',
      status: 'Offer Received',
    ));
  }

  // Function to handle the update when called from UpdateApplicationScreen
  void handleUpdate(int index, JobApplication updatedApplication) {
    jobApplicationsBox.putAt(index, updatedApplication);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Applications'),
      ),
      body: jobApplicationsBox.isNotEmpty
          ? buildJobApplicationsList()
          : buildEmptyState(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddApplicationScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildJobApplicationsList() {
    return ListView.builder(
      itemCount: jobApplicationsBox.length,
      itemBuilder: (context, index) {
        var application = jobApplicationsBox.getAt(index)!;
        return ListTile(
          title: Text(application.companyName),
          subtitle: Text('${application.position} - ${application.status}'),
          onTap: () async {
            // Navigator.push returns the updated application
            var updatedApplication = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApplicationDetailsScreen(
                  application: application,
                  onDelete: () => handleDelete(index),
                  onUpdate: (updatedApplication) => handleUpdate(index, updatedApplication), // Pass the handleUpdate function
                ),
              ),
            );

            if (updatedApplication != null) {
              // If the application is updated, update the UI
              jobApplicationsBox.putAt(index, updatedApplication);
              setState(() {});
            }
          },
        );
      },
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Text('No job applications found. Add a new one using the "+" button.'),
    );
  }

  // Function to handle deletion when called from ApplicationDetailsScreen
  void handleDelete(int index) {
    jobApplicationsBox.deleteAt(index);
    setState(() {});
  }
}