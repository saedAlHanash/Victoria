class ChangePasswordRequest {
  String oldPass;
  String newPass;



  ChangePasswordRequest({
    this.oldPass = '',
    this.newPass = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'old-password': oldPass,
      'password': newPass,

    };
  }

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      oldPass: map['old-password'] ?? '',
      newPass: map['password'] ?? '',

    );
  }
}
