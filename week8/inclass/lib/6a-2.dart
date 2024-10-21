import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import for handling local notifications
import 'dart:io' show Platform; // Import to detect the platform (iOS or Android)
import 'package:permission_handler/permission_handler.dart';  // Import to request permissions (Android 13+)

// Main entry point of the application
void main() {
  runApp(MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Setting up MaterialApp for app structure and theming
    return MaterialApp(
      title: 'Notification Demo', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Blue theme for the app
      ),
      home: NotificationPage(), // Home screen of the app
    );
  }
}

// StatefulWidget that will display the notification functionality
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState(); // Creates mutable state for this widget
}

//*** Notification Formality #Template
// Mutable state for NotificationPage
class _NotificationPageState extends State<NotificationPage> {

  //***************************************************************** NOTIFICATION TEMPLATE
  //***************************************************************** NOTIFICATION TEMPLATE
  //***************************************************************** NOTIFICATION TEMPLATE [Begin]
  // FlutterLocalNotificationsPlugin object to handle notifications
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    // Initialize the notification plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Define Android-specific settings (like using app icon for notifications)
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Combine Android-specific initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    //for both platforms
    // const InitializationSettings initializationSettings = InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   iOS: initializationSettingsIOS,
    // );

    // Initialize the notification plugin with the defined settings
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        // Handle notification tap event
        onSelectNotification(notificationResponse.payload);
        print("test");
        //you call other functions here
      },
    );

    // Request notification permission if running on Android 13+
    if (Platform.isAndroid) {
      _requestNotificationPermission();
    }
  }

  // Method to request notification permission on Android 13 and above
  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Check if notification permission is denied
      if (await Permission.notification.isDenied) {
        // Request notification permission from the user
        PermissionStatus status = await Permission.notification.request();
        if (status.isDenied) {
          print("Notification permission denied"); // Log if permission is denied
        } else if (status.isGranted) {
          print("Notification permission granted"); // Log if permission is granted
        }
      }
    }
  }
  //***************************************************************** NOTIFICATION TEMPLATE
  //***************************************************************** NOTIFICATION TEMPLATE
  //***************************************************************** NOTIFICATION TEMPLATE [End]

  // Method to handle when a notification is tapped
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      // Log the payload received when the notification is tapped
      print('Notification payload: $payload');
    }
  }

  // Method to show a simple notification
  Future<void> showNotification() async {
    // Define Android-specific notification details (channel ID, name, etc.)
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Unique channel ID
      'your_channel_name', // Channel name visible to the user
      channelDescription: 'your channel description', // Description for the channel
      importance: Importance.max, // Set importance to high for pop-up notifications
      priority: Priority.high, // Set priority to high
    );

    // Combine platform-specific settings (Android here)
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Display the notification
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID (0 for simplicity)
      'Hello!', // Title of the notification
      'This is a simple notification.', // Notification message
      platformChannelSpecifics, // Notification details (Android-specific in this case)
      payload: 'Notification Payload', // Optional payload to handle notification actions
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with the title
      appBar: AppBar(
        title: Text('Notification Demo'), // Title displayed in the app bar
      ),
      // Body of the app: contains a button to trigger the notification
      body: Center(
        // Elevated button to show a notification when pressed
        child: ElevatedButton(
          onPressed: showNotification, // Call showNotification when button is pressed
          child: Text('Show Notification'), // Text displayed on the button
        ),
      ),
    );
  }
}
