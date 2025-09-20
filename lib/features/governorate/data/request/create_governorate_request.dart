import '../response/governorate_response.dart';

class CreateGovernorateRequest {
  CreateGovernorateRequest({
    required this.id,
  });

  final String id;

  factory CreateGovernorateRequest.fromJson(Map<String, dynamic> json) {
    return CreateGovernorateRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateGovernorateRequest.fromGovernorate(Governorate governorate) {
    return CreateGovernorateRequest(
      id: governorate.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

