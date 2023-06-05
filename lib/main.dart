import 'package:flutter/material.dart';
import 'package:litexplorer_m3/smb_explorer_view.dart';
import 'punch_hole_view.dart';
import 'explorer_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LitExplorer',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const LitExHomePage(),
    );
  }
}

class LitExHomePage extends StatefulWidget {
  const LitExHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _LitExHomePageState();
}

class _LitExHomePageState extends State<LitExHomePage>{
  int _selectedPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> _globalPages = [];
  final _explorerKey = GlobalKey<ExplorerViewState>();
  final _transferViewKey = GlobalKey<PunchHoleViewState>();
  final _smbViewKey = GlobalKey<SMBExplorerViewState>();
  final _litShareViewKey = GlobalKey<SMBExplorerViewState>();

  void onNavbarTap(int idx){
    setState(() {
      _selectedPage = idx;
      _pageController.jumpToPage(_selectedPage);
    });
  }

  @override
  void initState() {
    super.initState();
    _globalPages = [
      ExplorerView(key: _explorerKey,),
      PunchHoleView(key: _transferViewKey,),
      SMBExplorerView(key: _smbViewKey,)
    ];
    _selectedPage = 0;
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
          children: [
            const DrawerHeader(child: Text("Quick Links")),
            ListTile(
              title: const Text("/sdcard/"),
              onTap: (){
                _explorerKey.currentState!.setExplorerDirectory("/sdcard/");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      appBar: AppBar(title: const Text("LitExplorer"),),
      body:WillPopScope(
        onWillPop: () async {return _explorerKey.currentState?.onWillPop() as Future<bool>;},
        child: Center(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (idx){
              setState(() {
                _selectedPage = idx;
              });
            },
            controller: _pageController,
            children: _globalPages,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: onNavbarTap,
        selectedIndex: _selectedPage,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.folder_open),
            icon: Icon(Icons.folder_open_outlined),
            label: "Explorer",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.import_export),
            icon: Icon(Icons.import_export_outlined),
            label: "Transfer",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.import_export),
            icon: Icon(Icons.import_export_outlined),
            label: "SMB",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
