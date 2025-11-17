class NotificationsResponse {
  NotificationsResponse({
    required this.data,
  });

  final List<NotificationModel> data;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      data: json["data"] == null
          ? []
          : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.notification,
    required this.isRead,
    required this.createdAt,
  });

  final String id;
  final NotificationData notification;
  final bool isRead;
  final DateTime? createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? "",
      notification: NotificationData.fromJson(json["notification"] ?? {}),
      isRead: json["is_read"] ?? false,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "notification": notification?.toJson(),
        "is_read": isRead,
        "created_at": createdAt?.toIso8601String(),
      };
}

class NotificationData {
  NotificationData({
    required this.title,
    required this.body,
    required this.productId,
    required this.orderId,
  });

  final String title;
  final String body;
  final int productId;
  final int orderId;

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      productId: json["product_id"] ?? 0,
      orderId: json["order_id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "product_id": productId,
        "order_id": orderId,
      };
}
