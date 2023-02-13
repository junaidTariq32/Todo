import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/core/utils/app_logger.dart';


enum Gender { male, female, x }

class UserModel {
  String? name;
  String? email;
  String? profileUrl;
  String? userId;
  bool? isActive;
  Timestamp? createdDate;

  UserModel(
      {this.name,
      this.email,
      this.profileUrl = '',
      this.userId,
      this.createdDate,
      this.isActive = true});

  UserModel.fromMap(Map<String, dynamic>? json) {
    try{
      name = json!['name'];
      email = json['email'];
      profileUrl = json['profileUrl'];
      userId = json['userId'];
      isActive = json['isActive'];

      createdDate = json['createdDate'];
    }catch(e){
      AppLogger().error(e);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profileUrl'] = profileUrl;
    data['userId'] = userId;
    data['isActive'] = isActive;
    data['createdDate'] = createdDate;
    return data;
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}
