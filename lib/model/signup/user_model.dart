import 'package:foodguru/utils/validation_functions.dart';

class UserData {
  late int id;
  late String name;
  late String email;
  late int currentTeamId;
  late String? profilePhotoPath;
  late String profilePhotoUrl;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = (json['name'] ?? "").toString().firstCapital();
    email = json['email'] ?? "";
    currentTeamId = json['current_team_id'] ?? 0;
    profilePhotoPath = json['profile_photo_path'] ?? "";
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
