import 'dart:convert';

DeviceRequest deviceRequestFromJson(String str) => DeviceRequest.fromJson(json.decode(str));

String deviceRequestToJson(DeviceRequest data) => json.encode(data.toJson());

class DeviceRequest {
  String? name;
  DeviceDetails? data;

  DeviceRequest({
    this.name,
    this.data,
  });

  factory DeviceRequest.fromJson(Map<String, dynamic> json) => DeviceRequest(
    name: json["name"],
    data: json["data"] == null ? null : DeviceDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": data?.toJson(),
  };
}

class DeviceDetails {
  int? year;
  double? price;
  String? cpuModel;
  String? hardDiskSize;

  DeviceDetails({
    this.year,
    this.price,
    this.cpuModel,
    this.hardDiskSize,
  });

  factory DeviceDetails.fromJson(Map<String, dynamic> json) => DeviceDetails(
    year: json["year"],
    price: json["price"]?.toDouble(),
    cpuModel: json["CPU model"],
    hardDiskSize: json["Hard disk size"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "price": price,
    "CPU model": cpuModel,
    "Hard disk size": hardDiskSize,
  };
}


DeviceResponse deviceResponseFromJson(String str) => DeviceResponse.fromJson(json.decode(str));

String deviceResponseToJson(DeviceResponse data) => json.encode(data.toJson());

class DeviceResponse {
  String? id;
  String? name;
  DeviceDetails? data;
  DateTime? createdAt;

  DeviceResponse({
    this.id,
    this.name,
    this.data,
    this.createdAt,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) => DeviceResponse(
    id: json["id"],
    name: json["name"],
    data: json["data"] == null ? null : DeviceDetails.fromJson(json["data"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "data": data?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

