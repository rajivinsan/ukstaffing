class WorkExperienceModel {
  final String employerName;
  final String startDate;
  final String? endDate;
  final int? cid;
  WorkExperienceModel(
      {required this.employerName,
      this.endDate,
      required this.startDate,
      this.cid});
  @override
  String toString() {
    return 'WorkExperience(name: $employerName, startDate: $startDate,endDate:$endDate)';
  }
}
