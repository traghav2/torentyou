import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torentyou/pages/HomePage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:torentyou/pages/NotificationsPage.dart';
import 'pages/onBoardingScreen.dart';
import 'package:torentyou/pages/PostAdsPage.dart';
import 'package:torentyou/pages/ProfilePage.dart';
import 'consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showOnboarding = true; // Track whether to show onboarding

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showOnboarding = prefs.getBool('showOnboarding') ?? true; // Default to true if not set
    setState(() {
      _showOnboarding = showOnboarding;
    });
  }

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showOnboarding', false); // Update shared preferences
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ... your MaterialApp configuration ...
      home: _showOnboarding ? OnBoardingScreen(
        onDone: _completeOnboarding, // Callback to complete onboarding
      ) : const MyHomePage(), // Show MyHomePage when onboarding is done
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const HomePage(),
    const PostAdsPage(),
    const NotificationsPage(),
  ];

  final List<String> drawerItems = [
    "Property", "Vehicle", "Furniture", "Appliances", "Hotels", "Home Stay",
    "Clothes", "Yachts and Helicopters", "Tools"
  ];

  final TextStyle itemTextStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.primaryTextColor,
    fontSize: 18,
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: AppColors.dividerColor.withOpacity(0.5),
          ),
        ),
        leading:  IconButton(icon: Icon(CupertinoIcons.bars, size: 30, color: Colors.grey.shade800,), onPressed: () => _scaffoldKey.currentState?.openDrawer(),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(child: Icon(CupertinoIcons.profile_circled, size: 30, color: Colors.grey.shade800), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),),
          )
        ],
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Image(image: AssetImage('assets/logo.png'),  // Replace with your logo file path
            width: 110,  // Adjust size as needed
            height: 110,),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                color: AppColors.dividerColor.withOpacity(0.5),
                width: 1.0,
              )
          ),
        ),
        child: NavigationBar(
          indicatorColor: AppColors.navbarPillColor,
          selectedIndex: _selectedIndex,
          elevation: 0,
          destinations: const [
            NavigationDestination(icon: Icon(LineIcons.home), label: 'Home'),
            NavigationDestination(icon: Icon(LineIcons.bullhorn), label: 'Post Ads'),
            NavigationDestination(icon: Icon(LineIcons.bell), label: 'Notifications')
          ],
          onDestinationSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.secondaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: drawerItems.map((item) =>
                  GestureDetector(
                    onTap: () {
                      // Handle item tap here (e.g., navigate to a new page)
                      print('Tapped on $item');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(item, style: itemTextStyle),
                    ),
                  ),
              ).toList(),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
