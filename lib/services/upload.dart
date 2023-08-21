import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Awsupload {
  String generatePresignedURL(String id) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHHmmssSSS');
    final String formatted = formatter.format(now);

    final accessKey = 'AKIAYDLF6W5KTC626BQI';
    final secretKey = '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';
    final region = 'ap-south-1';
    final bucketName = "sterling92775fd71f34443c884bcbd26f251536115246-devInfo";
    final objectKey = id + formatted;
    final int expirationSeconds = 31536000;

    final service = 's3';
    final host = '$bucketName.s3.$region.amazonaws.com';

    final expirationDateTime =
        DateTime.now().add(Duration(seconds: expirationSeconds));
    final expiration =
        expirationDateTime.toUtc().toIso8601String().split(".")[0] + 'Z';

    final signedHeaders = 'host';
    final canonicalHeaders = 'host:$host\n';

    final canonicalRequest =
        'GET\n/$objectKey\n\n$canonicalHeaders\n$signedHeaders\nUNSIGNED-PAYLOAD';
    final algorithm = 'AWS4-HMAC-SHA256';

    final date = expiration.substring(0, 8);
    final credentialScope = '$date/$region/$service/aws4_request';

    final stringToSign = '$algorithm\n$expiration\n$credentialScope\n'
        '${sha256.convert(utf8.encode(canonicalRequest)).toString()}';

    final kDate = _sign(
      utf8.encode('AWS4$secretKey'),
      utf8.encode(date),
    );
    final kRegion = _sign(kDate, utf8.encode(region));
    final kService = _sign(kRegion, utf8.encode(service));
    final signingKey = _sign(kService, utf8.encode('aws4_request'));

    final signature = _sign(signingKey, utf8.encode(stringToSign));

    final queryParams = {
      'X-Amz-Algorithm': algorithm,
      'X-Amz-Credential': '$accessKey/$credentialScope',
      'X-Amz-Date': date,
      'X-Amz-Expires': expirationSeconds.toString(),
      'X-Amz-SignedHeaders': signedHeaders,
      'X-Amz-Signature': signature,
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return 'https://$host/$objectKey?$queryString';
  }

  List<int> _sign(List<int> key, List<int> message) {
    final hmac = Hmac(sha256, key);
    return hmac.convert(message).bytes;
  }

  Future<String> uploadDocument(String sid, String filePath) async {
    var presignedUrl = generatePresignedURL(sid);
    final file = await http.MultipartFile.fromPath('file', filePath);
    final request = http.MultipartRequest('PUT', Uri.parse(presignedUrl));
    request.files.add(file);

    final response = await request.send();
    if (response.statusCode == 200) {
     // print('Document uploaded successfully');
      return presignedUrl;
    } else {
      print('Failed to upload document: ${response.reasonPhrase}');

      return "";
    }
  }
}
