import 'package:flutter/material.dart';
import 'package:kom_mendongeng/pages/home/anggota_page.dart';
import 'package:kom_mendongeng/pages/home/home_page.dart';
import 'package:kom_mendongeng/pages/home/konten_page.dart';
import 'package:kom_mendongeng/pages/home/mendongeng_page.dart';
import 'package:kom_mendongeng/pages/home/profile_page.dart';
import 'package:kom_mendongeng/theme.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget CustonBottomNav() {
      return BottomNavigationBar(
        backgroundColor: Color(0xffFAFAFA),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            print(value);
          });
        },
        selectedItemColor: secondaryColor,
        unselectedItemColor: Color(0xffD1D1D1),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(
                Icons.home,
                size: 28,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(
                Icons.bedroom_baby,
                size: 25,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(
                Icons.video_library,
                size: 28,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(
                Icons.people,
                size: 28,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Icon(
                Icons.person,
                size: 28,
              ),
            ),
            label: '',
          ),
        ],
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return MendongengPage();
        case 2:
          return KontenPage();
        case 3:
          return AnggotaPage();
        case 4:
          return ProfilePage();
        default:
          return HomePage();
      }
    }

    return Scaffold(
      bottomNavigationBar: CustonBottomNav(),
      body: body(),
    );
  }
}
