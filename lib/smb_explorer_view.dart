import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:dns_client/dns_client.dart';
import 'smb_pc_card.dart';

class SMBExplorerView extends StatefulWidget{
  const SMBExplorerView({Key? key}):super(key: key);

  @override
  State<SMBExplorerView> createState() => SMBExplorerViewState();
}

class SMBExplorerViewState extends State<SMBExplorerView> with AutomaticKeepAliveClientMixin<SMBExplorerView> {
  @override
  bool get wantKeepAlive => true;
  Set<String> jList = {};

  Future<void> _startDisc() async {
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP();
    final String? subnet = wifiIP?.substring(0, wifiIP.lastIndexOf('.'));
    final stream = NetworkAnalyzer.discover2(subnet!, 445);
    stream.listen((NetworkAddress addr) async {
      if (addr.exists) {
        setState(() {
          jList.add(addr.ip);
        });
        //final iaFilled = await InternetAddress("8.8.8.8").reverse();
        //setState(() {
        //  jList.add(iaFilled.host);
        //});
      }
    });

  }

  @override
  void initState() {
    super.initState();
    _startDisc().ignore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    super.build(context);
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: (jList.isEmpty)?
      const Text(
          "No SMB devices detected yet",
          textAlign: TextAlign.center,
        ):
        CustomScrollView(
          slivers:[
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 600,
                mainAxisExtent: 72,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: jList.length,
              itemBuilder: (BuildContext context, int index) {
                final ffElem = SMBElement(ip: jList.toList()[index],);
                return ffElem;
              },
            )
          ]
        )
    );
  }

}