import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

import 'lit_share_element.dart';

class LitShareView extends StatefulWidget{
  const LitShareView({Key? key}):super(key: key);

  @override
  State<LitShareView> createState() => LitShareViewState();
}

class LitShareViewState extends State<LitShareView> with AutomaticKeepAliveClientMixin<LitShareView> {
  @override
  bool get wantKeepAlive => true;
  Set<LitShareDeviceDetails> jList = {};

  Future<void> _startDisc() async {
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP();
    final String? subnet = wifiIP?.substring(0, wifiIP.lastIndexOf('.'));
    final stream = NetworkAnalyzer.discover2(subnet!, 4278);
    stream.listen((NetworkAddress addr) async {
      if (addr.exists) {

        setState(() {
          jList.add(LitShareDeviceDetails(addr.ip, addr.ip));
        });
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
        child: CustomScrollView(
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
                  final ffElem = LitShareElement(deviceDetails: jList.toList()[index],);
                  return ffElem;
                },
              )
            ]
        )
    );
  }

}