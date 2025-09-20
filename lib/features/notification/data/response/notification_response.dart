class NotificationsResponse {
  NotificationsResponse({
    required this.data,
  });

  final List<NotificationModel> data;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      data: json["data"] == null
          ? []
          : List<NotificationModel>.from(
              json["data"]!.map((x) => NotificationModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.image,
    required this.date,
    required this.status,
  });

  final int id;
  final String title;
  final String body;
  final String type;
  final dynamic data;
  final String image;
  final DateTime? date;
  final String status;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      type: json["type"] ?? "",
      data: json["data"],
      image: json["image"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "type": type,
        "data": data,
        "image": image,
        "date": date?.toIso8601String(),
        "status": status,
      };
}
