import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class LocalPeerDetails{
  String? name;
  String ipAddress;

  LocalPeerDetails({required this.ipAddress});
}

class LocalShareView extends StatefulWidget{
  const LocalShareView({super.key});

  @override
  State<StatefulWidget> createState() => LocalShareViewState();

}

class LocalShareViewState extends State<LocalShareView>{

  List<LocalPeerDetails> _peerList = [];

  Future<void> refreshPeerList() async{
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}