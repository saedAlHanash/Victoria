import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../strings/enum_manager.dart';
import '../util/shared_preferences.dart';
import 'helpers_api/helper_api_service.dart';
import 'helpers_api/log_api.dart';

var loggerObject = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    // number of method calls to be displayed
    errorMethodCount: 0,
    // number of method calls if stacktrace is provided
    lineLength: 300,
    // width of the output
    colors: true,
    // Colorful log messages
    printEmojis: false,
    // Print an emoji for each log message
    printTime: false,
  ),
);

class APIService {
  static final APIService _singleton = APIService._internal();

  APIService._internal() {
    Timer.periodic(
      Duration(seconds: 30),
      (t) => serverTime = serverTime.addFromNow(second: 30),
    );
  }
  DateTime serverTime = DateTime.now().toUtc();
  factory APIService() => _singleton;

  Map<String, String> get innerHeader => {
        'Content-Type': 'application/json',
        'Accept': 'Application/json',
        'lang': AppSharedPreference.getLocal,
        'Authorization': 'Bearer ${AppSharedPreference.getToken}',
      };

  Future<http.Response> callApi({
    required String url,
    required ApiType type,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? path,
    String? hostName,
    String? additional,
  }) async {
    // if (!await network.isConnected) noInternet;

    final uri = getUri(
      url: url,
      additional: additional,
      hostName: hostName,
      query: query ?? {},
      path: path,
      body: body,
      type: type,
    );
    try {
      late final http.Response response;

      switch (type) {
        case ApiType.get:
          response = await http
              .get(uri, headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.post:
          response = await http
              .post(uri, body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.put:
          response = await http
              .put(uri, body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.patch:
          response = await http
              .patch(uri, body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.delete:
          response = await http
              .delete(uri, body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
      }

      logResponse(url: url, response: response, type: type);
      serverTime = response.serverTime;
      return response;
    } catch (e) {
      loggerObject.e(e);
      return noInternet;
    }
  }

  Future<http.Response> uploadMultiPart({
    required String url,
    String? path,
    String type = 'POST',
    List<UploadFile?>? files,
    Map<String, dynamic>? fields,
  }) async {
    final uri = getUri(url: url, query: fields ?? {}, path: path, type: ApiType.post);

    var request = http.MultipartRequest(type, uri);

    for (var uploadFile in (files ?? <UploadFile?>[])) {
      if (uploadFile?.fileBytes == null) continue;

      final multipartFile = http.MultipartFile.fromBytes(
        uploadFile!.nameField,
        uploadFile.fileBytes!,
        filename: '${getRandomString(10)}.jpg',
      );

      request.files.add(multipartFile);
    }

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers.addAll(innerHeader);
    request.fields.addAll(fixFields(fields));

    final stream = await request.send().timeout(
          const Duration(seconds: 40),
          onTimeout: () => http.StreamedResponse(Stream.value([]), 481),
        );

    final response = await http.Response.fromStream(stream);

    logResponse(url: url, response: response, type: ApiType.post);

    return response;
  }
}

class UploadFile {
  UploadFile({
    this.fileBytes,
    this.initialImage,
    this.nameField = 'images[0]',
    this.assetImage = '',
    this.tempId,
    this.type,
  });

  Uint8List? fileBytes;
  String nameField;
  String? initialImage;
  dynamic assetImage;
  String? tempId;
  String? type;

  dynamic get getImage => fileBytes ?? (initialImage.isBlank ? null : initialImage) ?? assetImage;

  UploadFile copyWith({
    Uint8List? fileBytes,
    String? nameField,
  }) {
    return UploadFile(
      fileBytes: fileBytes ?? this.fileBytes,
      nameField: nameField ?? this.nameField,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'filelBytes': fileBytes,
      'nameField': nameField,
    };
  }

  factory UploadFile.fromMap(Map<String, dynamic> map) {
    return UploadFile(
      fileBytes: map['filelBytes'] as Uint8List,
      nameField: map['nameField'] as String,
    );
  }
}
