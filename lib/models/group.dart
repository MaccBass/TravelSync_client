class GroupMainInfo {
  final int groupID;
  final String guide;
  final String groupName;
  final DateTime startDate;
  final DateTime endDate;
  final String tourCompany;

  GroupMainInfo.fromJson(Map<String, dynamic> json)
      : groupID = json['groupId'],
        guide = json['guide'],
        groupName = json['groupName'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        tourCompany = json['tourCompany'];
}

class CreateGroup {
  final String guide;
  final String groupName;
  final String tourCompany;
  final DateTime startDate;
  final DateTime endDate;
  final String nation;
  final String groupPassword;

  CreateGroup(
      {required this.guide,
      required this.groupName,
      required this.tourCompany,
      required this.startDate,
      required this.endDate,
      required this.nation,
      required this.groupPassword});

  Map<String, dynamic> toJson() => {
        'guide': guide,
        'groupName': groupName,
        'tourCompany': tourCompany,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'nation': nation,
        'groupPassword': groupPassword
      };
}
