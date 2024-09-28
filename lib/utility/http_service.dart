import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class HttpService {
  static HttpService instance = HttpService.internal();
  HttpService.internal();
  factory HttpService() => instance;

  Map<String, String> headers = {};
  final JsonDecoder _decoder = const JsonDecoder();

  // static const String baseUrl = 'https://reimburse-server.koyeb.app/';
  static const String baseUrl = 'http://103.174.114.172:3000/';

  Future<dynamic> post({
    required String endpoint,
    Map headers = const {},
    Map body = const {},
    dynamic encoding,
  }) async {
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "auth-token": localStorage.getItem('auth-token') ?? '',
    };
    try {
      http.Response response = await http.post(
        Uri.parse(baseUrl + endpoint),
        body: json.encode(body),
        headers: requestHeaders,
        encoding: encoding,
      );
      log("res ==============> ${baseUrl + endpoint} \n===> body : $body \n===> response : ${response.body}");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception(
            "Error ${response.statusCode} while fetching endpoint ${baseUrl + endpoint}");
      }

      return _decoder.convert(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> postMultipart({
    required String endpoint,
    Map headers = const {},
    Map<String, String> body = const {},
    dynamic encoding,
    required dynamic files, // Ubah file menjadi dynamic agar bisa menerima List<File> atau File
  }) async {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      "auth-token": localStorage.getItem('auth-token') ?? '',
    };

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + endpoint),
      );

      request.headers.addAll(requestHeaders);
      request.fields.addAll(body);

      if (files is List<File>) {
        for (File file in files) {
          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          String? mimeType = lookupMimeType(file.path);
          if (mimeType == null ||
              !(mimeType.startsWith('image/jpeg') || mimeType.startsWith('image/png'))) {
            throw Exception(
                'Invalid file type: ${file.path}. Only .jpg, .jpeg, and .png are allowed.');
          }

          var multipartFile = http.MultipartFile(
            'files',
            stream,
            length,
            filename: file.path.split('/').last,
            contentType: MediaType.parse(mimeType), // Set MIME type
          );
          request.files.add(multipartFile);
        }
      } else if (files is File) {
        var stream = http.ByteStream(files.openRead());
        var length = await files.length();

        String? mimeType = lookupMimeType(files.path);
        if (mimeType == null ||
            !(mimeType.startsWith('image/jpeg') || mimeType.startsWith('image/png'))) {
          throw Exception(
              'Invalid file type: ${files.path}. Only .jpg, .jpeg, and .png are allowed.');
        }

        var multipartFile = http.MultipartFile(
          'file', // Nama field untuk file multipart, sesuaikan jika perlu
          stream,
          length,
          filename: files.path.split('/').last,
          contentType: MediaType.parse(mimeType), // Set MIME type
        );
        request.files.add(multipartFile);
      } else {
        throw Exception("Invalid file input. Expected File or List<File>.");
      }

      // Send the request
      var response = await request.send();

      // Read the response
      var responseBody = await response.stream.bytesToString();

      log("res ==============> ${baseUrl + endpoint} \n===> body : $body \n===> response : ${responseBody}");

      if (response.statusCode < 200 || response.statusCode > 400) {
        throw Exception(
            "Error ${response.statusCode} while fetching endpoint ${baseUrl + endpoint}");
      }

      return _decoder.convert(responseBody);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
