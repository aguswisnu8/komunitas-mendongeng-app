import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kom_mendongeng/pages/crud/add_konten_page.dart';
import 'package:kom_mendongeng/pages/crud/add_mendongeng_page.dart';
import 'package:kom_mendongeng/pages/crud/add_undangan_page.dart';
import 'package:kom_mendongeng/pages/daftar_page.dart';
import 'package:kom_mendongeng/pages/detail_anggota_page.dart';
import 'package:kom_mendongeng/pages/detail_konten_page.dart';
import 'package:kom_mendongeng/pages/detail_mendongeng_page.dart';
import 'package:kom_mendongeng/pages/home/main_page.dart';
import 'package:kom_mendongeng/pages/login_page.dart';
import 'package:kom_mendongeng/pages/profile/admin/admin_akun_page.dart';
import 'package:kom_mendongeng/pages/profile/admin/admin_konten_page.dart';
import 'package:kom_mendongeng/pages/profile/admin/admin_mendongeng_page.dart';
import 'package:kom_mendongeng/pages/profile/admin/admin_partisipan_page.dart';
import 'package:kom_mendongeng/pages/profile/admin/admin_undangan_page.dart';
import 'package:kom_mendongeng/pages/profile/edit_profile_page.dart';
import 'package:kom_mendongeng/pages/profile/user_konten_page.dart';
import 'package:kom_mendongeng/pages/profile/user_partisipasi_page.dart';
import 'package:kom_mendongeng/pages/profile/user_undangan_page.dart';
import 'package:kom_mendongeng/pages/profile/reset_password_page.dart';
import 'package:kom_mendongeng/pages/splash_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/providers/konten_provider.dart';
import 'package:kom_mendongeng/providers/mendongeng_provider.dart';
import 'package:kom_mendongeng/providers/page_provider.dart';
import 'package:kom_mendongeng/providers/partisipan_provider.dart';
import 'package:kom_mendongeng/providers/undangan_provider.dart';
import 'package:kom_mendongeng/providers/anggota_provider.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // if (notification != null && android != null && !kIsWeb) {
  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('mendongeng');

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      //
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MendongengProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => KontenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UndanganProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AnggotaProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PartisipanProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/daftar': (context) => DaftarPage(),
          '/home': (context) => MainPage(),
          // detail
          // '/d-mendongeng': (context) => DetailMendongengPage(),
          // '/d-konten': (context) => DetailKontenPage(),
          // '/d-anggota': (context) => DetailAnggotaPage(),

          // profile
          // '/p-edit': (context) => EditProfilePage(),
          '/p-resetpass': (context) => ResetPasswordPage(),
          '/p-userkonten': (context) => UserKontenPage(),
          '/p-userundangan': (context) => UserUndanganPage(),
          '/p-userpartisipasi': (context) => UserPartisipasiPage(),

          // admin
          '/a-akun': (context) => AdminAkunPage(),
          '/a-mendongeng': (context) => AdminMendongengPage(),
          '/a-partisipan': (context) => AdminPartisipanPage(),
          '/a-konten': (context) => AdminKontenPage(),
          '/a-undangan': (context) => AdminUndanganPage(),

          // crud
          '/add-konten': (context) => AddKontenPage(),
          '/add-undangan': (context) => AddUndanganPage(),
          '/add-mendongeng': (context) => AddMendongengPage(),
          // '/edit-akun': (context) => EditAkunPage(),
        },
        // home: SplashPage(),
      ),
    );
  }
}
