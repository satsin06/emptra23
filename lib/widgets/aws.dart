import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';


class AmplifyCall {

  void configureAmplify() async {
    AmplifyStorageS3 storage = new AmplifyStorageS3();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin, storage]);
    try {
      await Amplify.configure(amplifyconfig);
      print(' Successfully configured Amplify 🎉');
    } catch (e) {
      print(e);
      print(' Could not configure Amplify ☠️');
    }
  }


  Future upload(selectedFileResult,designation) async {
    try {
      print('In upload');
      final selectedFileResult = await FilePicker.platform.pickFiles(allowCompression: true);
      if (selectedFileResult != null) {
        // final local = selectedFileResult;
        final local = File(selectedFileResult.files.single.path);
        final extension = local.path.split('.').last.toLowerCase();
        final key = '$designation${DateTime.now()}.$extension';
        Map<String, String> metadata = <String, String>{};
        metadata['name'] = 'smiley_face';
        metadata['desc'] = 'A photo of a smiley face';
        S3UploadFileOptions options = S3UploadFileOptions(
            accessLevel: StorageAccessLevel.guest, metadata: metadata);
        UploadFileResult result = await Amplify.Storage.uploadFile(
            key: key, local: local, options: options);
        return result.key;
      }
      else{
        print('no file selected');
      }
    } catch (e) {
      print('UploadFile Err: ' + e.toString());
      return Future.error ('Error to upload');
    }
  }

  Future getUrl(retrievedKey) async {
    try {
      String key = retrievedKey;
      S3GetUrlOptions options = S3GetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
        // expires: 10000,
        // targetIdentityId: '892bcb3c-1e07-4784-8698-757bdc18bdea',
      );
      GetUrlResult result =
      await Amplify.Storage.getUrl(key: key, options: options);
      return result.url;
    } catch (e) {
      print('GetUrl Err: ' + e.toString());
    }
  }


  Future uploadPicture(designation,badgeID) async {
    try {
      print('In upload');
      final selectedFileResult = await FilePicker.platform.pickFiles(allowCompression: true);
      if (selectedFileResult != null) {
        final local = File(selectedFileResult.files.single.path);
        final extension = local.path.split('.').last;
        final key = '$designation$badgeID';
        Map<String, String> metadata = <String, String>{};
        metadata['name'] = 'smiley_face';
        metadata['desc'] = 'A photo of a smiley face';
        S3UploadFileOptions options = S3UploadFileOptions(
            accessLevel: StorageAccessLevel.guest, metadata: metadata);
        UploadFileResult result = await Amplify.Storage.uploadFile(
            key: key,
            local: local, options: options);
        return result.key;
      }
      else{
        print('no file selected');
      }
    } catch (e) {
      print('UploadFile Err: ' + e.toString());
    }
  }

  Future remove() async {
    try {
      print('In remove');
      String key = "ExampleKey";
      RemoveOptions options =
      RemoveOptions(accessLevel: StorageAccessLevel.guest);
      RemoveResult result =
      await Amplify.Storage.remove(key: key, options: options);
      return result.key;
    } catch (e) {
      print('Remove Err: ' + e.toString());
    }
  }

  void list() async {
    try {
      print('In list');
      S3ListOptions options =
      S3ListOptions(accessLevel: StorageAccessLevel.guest);
      ListResult result = await Amplify.Storage.list(options: options);
      print('List Result:');
      for (StorageItem item in result.items) {
        print(
            'Item: { key:${item.key}, eTag:${item.eTag}, lastModified:${item.lastModified}, size:${item.size}');
      }
    } catch (e) {
      print('List Err: ' + e.toString());
    }
  }

  Future signIn() async {
    try{
      final res = await Amplify.Auth.signInWithWebUI();
      if (res.isSignedIn){
        final attributes = await Amplify.Auth.fetchUserAttributes();
        //Checking the attributes from AD login
        for (int i = 0; i < attributes.length; i++) {
          if (attributes[i].value.toString().endsWith('@someemail.com.my')) {
            // print("name: " + attributes[i].value.split("@").first);
            return attributes[i].value.toString();
          }
          else{
            if (attributes[i].value.toString().endsWith('@gmail.com')){
              print(attributes[i].value);
              return attributes[i].value.toString();
            }
            // print(attributes[i].value);
          }
        }
      }
    } on AuthException catch (e){
      print(e);
      Amplify.Auth.signOut();
      return false;
    }
  }
}