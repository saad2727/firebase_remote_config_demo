import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote Config Example',
      home: RemoteConfigExample(),
    );
  }
}

class RemoteConfigExample extends StatefulWidget {
  @override
  _RemoteConfigExampleState createState() => _RemoteConfigExampleState();
}

class _RemoteConfigExampleState extends State<RemoteConfigExample> {
final remoteConfig = FirebaseRemoteConfig.instance;
 

  @override
  void initState() {
    super.initState();
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    _remoteConfig = RemoteConfig.instance;
    await _remoteConfig.setDefaults(<String, dynamic>{
      'welcome_message': 'Welcome to our app!',
    });

    try {
      await _remoteConfig.fetch();
      await _remoteConfig.activate();
    } catch (e) {
      print("Error fetching remote config: $e");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Config Example'),
      ),
      body: Center(
        child: Text(
          _remoteConfig.getString('welcome_message'),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
