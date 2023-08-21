import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:intl/intl.dart';

import '../amplifyconfiguration.dart';

class AwsS3Configuration {
  static Future<void> configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      final storage = AmplifyStorageS3();
      await Amplify.addPlugins([storage, auth]);

      // Call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  static Future<String> upload({required String path}) async {
    try {
      File local = File(path);
      final key = DateTime.now().toString();
      Map<String, String> metadata = <String, String>{};
      metadata['name'] = 'filename';
      metadata['desc'] = 'A test file';
      S3UploadFileOptions options = S3UploadFileOptions(
        accessLevel: StorageAccessLevel.guest,
        metadata: metadata,
      );

      var result = await Amplify.Storage.uploadFile(
        key: key,
        local: local,
        options: options,
        onProgress: (progress) {
          //("PROGRESS: ${progress.getFractionCompleted()}");
        },
      );
      return result.key;
    } catch (e) {
      print('UploadFile Err: $e');
      return "";
    }
  }

  
  }
