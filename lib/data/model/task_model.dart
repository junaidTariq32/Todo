import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus {
  progress,
  done,
  canceled,
}

class TaskModel {
  String? id;
  Timestamp? createdAt;
  Timestamp? startDate;
  Timestamp? startTime;
  String? title;
  String? description;
  TaskStatus? status;

  TaskModel(
      {this.id,
      this.createdAt,
      this.startTime,
      this.title,
      this.startDate,
      this.description,
      this.status});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    startTime = json['start_time'];
    startDate = json['start_date'];
    title = json['title'];
    status = TaskStatus.values.elementAt(json['status']);
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['start_time'] = startTime;
    data['start_date'] = startDate;
    data['title'] = title;
    data['status'] = status?.index ?? 0;
    data['description'] = description;
    return data;
  }

  TaskModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data() as Map<String, dynamic>);
}
