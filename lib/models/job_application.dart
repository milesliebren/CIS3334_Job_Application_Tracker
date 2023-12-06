import 'package:hive/hive.dart';

part 'job_application.g.dart';

@HiveType(typeId: 0)
class JobApplication extends HiveObject {
  @HiveField(0)
  late String companyName;

  @HiveField(1)
  late String position;

  @HiveField(2)
  late String status;

  // Add other fields as needed

  JobApplication({
    required this.companyName,
    required this.position,
    required this.status,
    // Add other parameters as needed
  });
}