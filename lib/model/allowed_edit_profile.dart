class AllowedEditProfile {
  int id;
  int groupId;
  int isEnabled;
  int availableFields;

  AllowedEditProfile(
      {required this.id,
      required this.groupId,
      required this.isEnabled,
      required this.availableFields});

  AllowedEditProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        groupId = json['group_id'],
        isEnabled = json['is_enabled'],
        availableFields = json['available_fields'];
}
