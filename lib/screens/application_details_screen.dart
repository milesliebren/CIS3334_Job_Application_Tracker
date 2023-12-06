import 'package:flutter/material.dart';
import 'package:cis3334_job_application_tracker/models/job_application.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  final JobApplication application;

  ApplicationDetailsScreen({Key? key, required this.application}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Details'),
      ),
      body: Center(
        child: Text('Details for ${application.companyName}'),
      ),
    );
  }
}