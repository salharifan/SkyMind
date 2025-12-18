import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'core/services/notification_service.dart';
import 'core/services/db_service.dart';

import 'features/alerts/view/alerts_screen.dart';

import 'features/favourites/view/favourites_screen.dart';
import 'features/forecast/view/forecast_screen.dart';
import 'features/home/view/home_screen.dart';
import 'features/region/view/regionfilter_screen.dart';
import 'features/settings/view_model/settings_view_model.dart';

const String vectorAlertTask = "weatherAlertTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == vectorAlertTask) {
      final notificationService = NotificationService();
      await notificationService.init();

      // Record alert in SQLite database
      final dbService = DatabaseService();
      await dbService.insertAlert(
        "Background Update",
        "Scheduled weather check performed successfully.",
        DateTime.now(),
      );

      await notificationService.showNotification(
        0,
        "Weather Alert",
        "Check your favorite cities for updates!",
      );
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.init();

  // Initialize Workmanager
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "1",
    vectorAlertTask,
    frequency: const Duration(minutes: 15),
    initialDelay: const Duration(seconds: 10),
  );

  runApp(const ProviderScope(child: SkyMindApp()));
}

class SkyMindApp extends ConsumerWidget {
  const SkyMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final themeMode = settingsState.themeMode;

    return MaterialApp(
      title: 'SkyMind',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.lightBlue.shade50,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FavouritesScreen(),
    ForecastScreen(city: "London"),
    RegionFilterScreen(),
    AlertsScreen(),
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    _controller.reset();
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(index: _selectedIndex, children: _pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favs',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            label: 'Forecast',
          ),
          NavigationDestination(icon: Icon(Icons.public), label: 'Region'),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}
