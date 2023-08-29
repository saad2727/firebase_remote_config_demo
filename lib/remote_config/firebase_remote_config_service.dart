import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config_demo/main.dart';
import 'package:firebase_remote_config_demo/model/remote_config_model.dart';


class FirebaseRemoteConfigService {
  static List remoteModel = <RemoteConfigModel>[];
  void loadData() {
    if (prefs!.containsKey('post_data')) {
      var data = prefs!.getString('post_data')!;
      var decodedData = jsonDecode(data);

      remoteModel.clear();
      for (var element in decodedData) {
        remoteModel.add(
          RemoteConfigModel(
              userId: element['userId'],
              id: element['id'],
              title: element['title'],
              body: element['body']),
        );
      }
    }
  }
}
