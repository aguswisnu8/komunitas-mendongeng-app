import 'package:flutter/material.dart';
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          '/p-edit': (context) => EditProfilePage(),
          '/p-resetpass': (context) => ResetPasswordPage(),
          '/p-userkonten': (context) => UserKontenPage(),
          '/p-userundangan': (context) => UserUndanganPage(),

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
