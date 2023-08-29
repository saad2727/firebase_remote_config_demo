import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_remote_config_demo/firebase_notification_message/firebase_notification_messaging.dart';
import 'package:firebase_remote_config_demo/remote_config/firebase_remote_config_service.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// ...
final remoteConfig = FirebaseRemoteConfig.instance;
SharedPreferences? prefs;
void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() async {
    await remoteConfig
        .setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ))
        .whenComplete(() async {
      await remoteConfig.fetch().whenComplete(() async {
        await remoteConfig.activate().whenComplete(() async {
          prefs!.setString('post_data', remoteConfig.getString('post_data'));
          FirebaseRemoteConfigService().loadData();
        });
      });
    });
  });
  await FirebaseNotificationMessageing().initNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: FirebaseRemoteConfigService.remoteModel.length,
                itemBuilder: ((context, index) {
                  return Text(FirebaseRemoteConfigService.remoteModel[index].id
                      .toString());
                })),
          ),
        ));
  }
}
