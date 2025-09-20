import '../response/ads_response.dart';

class CreateAdsRequest {
  CreateAdsRequest({
    required this.id,
  });

  final String id;

  factory CreateAdsRequest.fromJson(Map<String, dynamic> json) {
    return CreateAdsRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateAdsRequest.fromAds(Ads ads) {
    return CreateAdsRequest(
      id: ads.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

