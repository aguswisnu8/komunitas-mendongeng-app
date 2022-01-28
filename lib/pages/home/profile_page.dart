import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/image_profile.png',
                    width: 64,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, Agus Wisnu Kusuma Nata',
                        style: whiteTextStyle.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                      Text(
                        'aguswisnu8@gmail.com',
                        style: whiteTextStyle.copyWith(),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      flag = false;
                    });
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        // margin: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: greyTextStyle.copyWith(fontSize: 13),
                ),
                Icon(
                  Icons.chevron_right,
                  color: greyTextColor,
                ),
              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/p-edit');
                    },
                    child: menuItem('Edit Profile'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/p-resetpass');
                    },
                    child: menuItem('Reset Password'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/p-userkonten');
                    },
                    child: menuItem('Konten'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/p-userundangan');
                    },
                    child: menuItem('Undangan'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Text(
                'Pengelolaan Admin',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/a-akun');
                },
                child: menuItem('Akun'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/a-mendongeng');
                },
                child: menuItem('Kegitan Mendongeng'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/a-partisipan');
                },
                child: menuItem('Partispan'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/a-konten');
                },
                child: menuItem('Konten'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/a-undangan');
                },
                child: menuItem('Undangan'),
              ),
            ],
          ),
        ),
      );
    }
    // Widget login(){
    //   return
    // }


    Widget auth() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/bali_mendongeng.png',
            width: 200,
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Text(
              'Mari bergabung bersama kami melestarikan budaya mendongeng untuk adik, anak, dan cucu kita',
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 44,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/daftar');
              },
              child: Text(
                'Daftar Anggota',
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 24,
                ),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 44,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Login',
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 24,
                ),
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 44,
            child: TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/login');
                setState(() {
                  flag = true;
                });
              },
              child: Text(
                'Halaman Profile',
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 24,
                ),
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget logged() {
      return Column(
        children: [
          header(),
          content(),
        ],
      );
    }

    return Center(
      child: flag ? logged() : auth(),
    );
  }
}
