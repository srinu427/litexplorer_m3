import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/services.dart';
import 'package:litexplorer_m3/blur_wrapper.dart';
import 'punch_hole_lib.dart';
import 'package:http/http.dart' as http;

Future<String> manualPubIP() async{
  var url = Uri.https("api64.ipify.org");
  var response = await http.get(url);
  return response.body;
}

class PunchHoleView extends StatefulWidget{
  const PunchHoleView({super.key});

  @override
  State<StatefulWidget> createState() => PunchHoleViewState();

}

class PunchHoleViewState extends State<PunchHoleView>  with AutomaticKeepAliveClientMixin<PunchHoleView>{
  String myIP = "";
  var peerIpController = TextEditingController();
  var peerPortController = TextEditingController();
  var recvPortController = TextEditingController();
  final _pageController = PageController(initialPage: 0);
  var _currentPage = 0;

  Future<void> updateMyIP() async {
    Ipify.ipv64().then((value) {
      setState(() {
        myIP = value;
      });
    }).catchError(
      (e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString(),),
          ),
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    updateMyIP().ignore();
    peerIpController.text = "127.0.0.1";
    peerPortController.text = "4278";
    recvPortController.text = "4278";

    //_pages = [Text("lol1"),Text("lol1"),Text("lol1"),];
  }

  Widget makeConnRecvUI(){
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: SizedBox(
                  child: TextField(
                    controller: peerIpController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Peer IP Address",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: peerPortController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Peer Port",
                  ),
                ),
              ),
            ]
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
            onPressed: (){},
            child: const Text("Connect to peer",),
          )
        ],
      ),
    );
  }

  Widget makeStartRecvUI(){
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("My IP: "),
          const SizedBox(height: 16,),
          Text(myIP),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: myIP))
                        .whenComplete(
                            () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Copied public IP $myIP")),
                        )
                    );
                  },
                  icon: const Icon(Icons.copy)),
              IconButton(onPressed: updateMyIP, icon: const Icon(Icons.refresh)),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                SizedBox(
                  width: 112,
                  child: TextField(
                    controller: recvPortController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Receiver Port",
                    ),
                  ),
                ),
              ]
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
            onPressed: (){},
            child: const Text("Start Receiver",),
          )
        ],
      ),
    );
  }

  Widget makeHolePunchUI(){
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("My IP: "),
          const SizedBox(height: 16,),
          Text(myIP),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: myIP))
                        .whenComplete(
                            () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Copied public IP $myIP")),
                        )
                    );
                  },
                  icon: const Icon(Icons.copy)),
              IconButton(onPressed: updateMyIP, icon: const Icon(Icons.refresh)),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(
                width: 80,
                child: TextField(
                  controller: recvPortController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "My Port",
                  ),
                ),
              ),
            ]
          ),
          const SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: SizedBox(
                  child: TextField(
                    controller: peerIpController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Peer IP Address",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: peerPortController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Peer Port",
                  ),
                ),
              ),
            ]
          ),
          const SizedBox(height: 32,),
          ElevatedButton(
            onPressed: () async{
              await punchHoleToPeer(
                  InternetAddress(peerIpController.text),
                  int.parse(peerPortController.text),
                  int.parse(recvPortController.text)
              );
            },
            child: const Text("Punch hole",),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          BlurWrapper(
            sigmaX: 8, sigmaY: 8,
            clipBorderRadius: BorderRadius.circular(12),
            child: NavigationRail(
              backgroundColor: Colors.white10,
              labelType: NavigationRailLabelType.none,
              destinations: const [
                NavigationRailDestination(
                  label: Text("Start receiver"),
                  icon: Icon(Icons.file_download_rounded),
                  selectedIcon: Icon(Icons.file_download_rounded),
                ),
                NavigationRailDestination(
                  label: Text("Connect to peer"),
                  icon: Icon(Icons.sync_alt_outlined),
                  selectedIcon: Icon(Icons.sync_alt),
                ),
                NavigationRailDestination(
                  label: Text("Punch hole"),
                  icon: Icon(Icons.connect_without_contact_outlined),
                  selectedIcon: Icon(Icons.connect_without_contact),
                ),
              ],
              onDestinationSelected: (idx){
                setState(() {
                  _pageController.jumpToPage(idx);
                  _currentPage = idx;
                });
              },
              selectedIndex: _currentPage,
            )
          ),
          Expanded(
            //width: 200,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [makeStartRecvUI(), makeConnRecvUI(), makeHolePunchUI()],
              onPageChanged: (idx){
                setState(() {
                  _currentPage = idx;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    peerIpController.dispose();
    peerPortController.dispose();
    recvPortController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

}