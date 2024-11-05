class NewActivitiesModel {
  final String crActivity;
  final String crNumber;

  NewActivitiesModel({
    required this.crActivity,
    required this.crNumber,
  });

  factory NewActivitiesModel.fromJson(Map<String, dynamic> json) {
    return NewActivitiesModel(
      crActivity: json['cr_activity'] ?? '',
      crNumber: json['cr_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cr_activity': crActivity,
      'cr_number': crNumber,
    };
  }
}
