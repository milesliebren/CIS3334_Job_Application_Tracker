import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'application_details_screen.dart';
import 'package:cis3334_job_application_tracker/models/job_application.dart';
import 'package:cis3334_job_application_tracker/screens/add_application_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<JobApplication>? jobApplicationsBox = Hive.box<JobApplication>('jobApplications');

  @override
  void initState() {
    super.initState();
    openHiveBox();
  }

  Future<void> openHiveBox() async {
    await Hive.openBox<JobApplication>('jobApplications');
    jobApplicationsBox = Hive.box<JobApplication>('jobApplications');
    // Add sample job applications for testing if the box is empty
    if (jobApplicationsBox!.isEmpty) {
      await addSampleJobApplications();
    }
    setState(() {});
  }

  Future<void> addSampleJobApplications() async {
    await jobApplicationsBox!.add(JobApplication(
      companyName: 'Sample Company 1',
      position: 'Software Engineer',
      status: 'Applied',
    ));

    await jobApplicationsBox!.add(JobApplication(
      companyName: 'Sample Company 2',
      position: 'Product Manager',
      status: 'Interviewing',
    ));

    await jobApplicationsBox!.add(JobApplication(
      companyName: 'Sample Company 3',
      position: 'Data Analyst',
      status: 'Offer Received',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Applications'),
      ),
      body: jobApplicationsBox != null && jobApplicationsBox!.isNotEmpty
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
      itemCount: jobApplicationsBox!.length,
      itemBuilder: (context, index) {
        var application = jobApplicationsBox!.getAt(index)!;
        return ListTile(
          title: Text(application.companyName),
          subtitle: Text('${application.position} - ${application.status}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApplicationDetailsScreen(application: application),
              ),
            );
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
}