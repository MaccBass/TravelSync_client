import 'dart:convert';

import 'package:travelsync_client/models/group.dart';
import 'package:http/http.dart' as http;

class GroupApi {
  static const String baseUrl = "http://http://34.83.150.5:8080";

  static Future<GroupMainInfo> getGroupInfo(int groupId) async {
    GroupMainInfo groupMainInfo;
    final url = Uri.parse('$baseUrl/group/info/$groupId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final info = jsonDecode(response.body);
      groupMainInfo = (GroupMainInfo.fromJson(info));
      return groupMainInfo;
    }
    throw Error();
  }

  static Future<http.Response> postCreateGroup(CreateGroup group) async {
    var body = json.encode(group.toJson());

    return await http.post(
      Uri.parse('$baseUrl/group/create'),
      body: body,
    );
  }
}
