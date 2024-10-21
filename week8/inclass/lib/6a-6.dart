import 'dart:io';  // Detect the platform (iOS or Android)
import 'package:flutter/material.dart';  // Flutter UI framework
import 'package:flutter_local_notifications/flutter_local_notifications.dart';  // Import for handling notifications
import 'package:timezone/timezone.dart' as tz;  // Timezone package to manage scheduling notifications
import 'package:timezone/data/latest.dart' as tz;  // Initialize the latest timezone data
import 'package:permission_handler/permission_handler.dart';  // Permission handler, especially useful for Android 13+

// import 'notifications.dart';  // Importing a custom Notifications class (optional, could hold additional notification logic)

// Main entry point of the app
void main() {
  runApp(const MyApp());  // Running the root widget of the application
}

// Root widget (StatelessWidget) that holds the basic structure of the app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Example',  // App title
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Sets the theme's primary color
      ),
      home: const MyHomePage(title: 'Notification Home Page'),  // Sets the home page of the app
    );
  }
}

// StatefulWidget for handling user inputs and managing notifications
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;  // Title for the AppBar

  @override
  State<MyHomePage> createState() => _MyHomePageState();  // Creates the mutable state for this widget
}

// State for MyHomePage where the logic resides
class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();  // Key for form validation
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;  // Plugin instance to handle notifications
  String? title;  // Notification title entered by the user
  String? body;  // Notification body entered by the user
  String? payload;  // Payload for when the notification is tapped

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();  // Initialize timezone data for scheduling
    _initializeNotifications();  // Initialize the notification system
  }

  // Method to initialize notification plugin and request permissions (for Android 13+)
  Future<void> _initializeNotifications() async {
    // Initialize the FlutterLocalNotificationsPlugin instance
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android-specific initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');  // Icon for the notifications

    // Combine platform-specific initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin and set up the notification response handling
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        _onSelectNotification(notificationResponse.payload);  // Handle notification taps
      },
    );

    // Request notification permissions if on Android 13 or higher
    if (Platform.isAndroid) {
      await _requestNotificationPermission();  // Call the permission handler
    }
  }

  // Request notification permission for Android 13+
  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Check if notification permission is denied
      if (await Permission.notification.isDenied) {
        // Request notification permission from the user
        PermissionStatus status = await Permission.notification.request();
        if (status.isDenied) {
          print("Notification permission denied");  // Log if permission is denied
        } else if (status.isGranted) {
          print("Notification permission granted");  // Log if permission is granted
        }
      }
    }
  }

  // Method to send a notification immediately
  Future<void> _notificationNow() async {
    // Define Android-specific notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',  // Channel ID
      'your_channel_name',  // Channel name
      channelDescription: 'your channel description',  // Description for the channel
      importance: Importance.max,  // Maximum importance for the notification
      priority: Priority.high,  // High priority to make the notification pop-up
    );

    // Combine platform-specific notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Display the notification
    await flutterLocalNotificationsPlugin.show(
      0,  // Notification ID
      title ?? 'Default Title',  // Title of the notification
      body ?? 'This is a simple notification.',  // Body of the notification
      platformChannelSpecifics,  // Notification details (Android)
      payload: 'Notification Payload',  // Payload to handle notification taps
    );
  }

  // Method to handle notification taps
  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');  // Log the payload when the notification is tapped
    }
  }

  // Schedule a notification to appear 3 seconds later
  Future<void> _notificationLater() async {
    var when = tz.TZDateTime.now(tz.local).add(Duration(seconds: 3));  // Schedule notification 3 seconds from now

    // Android-specific notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',  // Channel ID
      'your_channel_name',  // Channel name
      channelDescription: 'your channel description',  // Channel description
      importance: Importance.max,  // Maximum importance
      priority: Priority.high,  // High priority for notification pop-up
    );

    // Combine platform-specific notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Schedule the notification to appear in 3 seconds
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,  // Notification ID
      title ?? 'Scheduled Title',  // Title of the scheduled notification
      body ?? 'This is a scheduled notification.',  // Body of the scheduled notification
      when,  // When the notification should appear
      platformChannelSpecifics,  // Notification details (Android)
      androidAllowWhileIdle: true,  // Allow notifications when the phone is idle
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,  // Absolute time interpretation
    );

    // Show a SnackBar to confirm the notification scheduling
    var snackBar = SnackBar(
      content: Text("Notification in 3 seconds"),  // SnackBar message
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);  // Show the SnackBar
  }

  // Main UI of the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),  // Title in the AppBar
        actions: [
          IconButton(
            onPressed: _notificationNow,  // Send notification immediately when pressed
            icon: Icon(Icons.notifications),  // Icon for immediate notification
          ),
          IconButton(
            onPressed: _notificationLater,  // Schedule notification when pressed
            icon: Icon(Icons.timer_3),  // Icon for scheduled notification
          ),
        ],
      ),
      body: Builder(  // Builder widget to provide a context for the form
        builder: _formBuilder,
      ),
    );
  }

  // Form builder for user inputs (title, body, payload)
  Widget _formBuilder(BuildContext context) {
    return Form(
      key: _formKey,  // Key to validate the form
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Aligns child widgets to the start
        children: [
          // Text input for the notification title
          TextFormField(
            decoration: const InputDecoration(labelText: "Title"),  // Label for the input field
            onChanged: (value) {
              title = value;  // Update the title with user input
            },
          ),
          // Text input for the notification body
          TextFormField(
            decoration: const InputDecoration(labelText: "Body"),  // Label for the body input field
            onChanged: (value) {
              body = value;  // Update the body with user input
            },
          ),
          // Text input for the payload (optional data sent with notification)
          TextFormField(
            decoration: const InputDecoration(labelText: "Payload"),  // Label for the payload input field
            onChanged: (value) {
              payload = value;  // Update the payload with user input
            },
          ),
        ],
      ),
    );
  }
}
