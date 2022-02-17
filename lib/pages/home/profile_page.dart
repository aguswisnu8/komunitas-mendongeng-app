import 'package:flutter/material.dart';
import 'package:kom_mendongeng/api_config.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/profile/edit_profile_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel user;

    // String level = 'anggota';
    // String? name;
    // String? email;
    // String? image;
    bool flag = authProvider.logged;

    // if (flag) {
    //   user = authProvider.user;
    //   level = user.level.toString();
    //   name = user.name;
    //   email = user.email;
    //   image = user.profilePhotoPath;
    // }

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
                cekImage(authProvider.currentUser.profilePhotoPath.toString())
                    ? ClipOval(
                        child: Image.network(
                          authProvider.currentUser.profilePhotoPath.toString(),
                          width: 80,
                          fit: BoxFit.cover,
                          height: 80,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          'assets/image_profile.png',
                          width: 80,
                          fit: BoxFit.cover,
                          height: 80,
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
                        // 'Hallo, Agus Wisnu Kusuma Nata',
                        'Hallo, ${authProvider.currentUser.name}',
                        style: whiteTextStyle.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                      Text(
                        // 'aguswisnu8@gmail.com',
                        '${authProvider.currentUser.email}',
                        style: whiteTextStyle.copyWith(),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (await authProvider
                        .logout(authProvider.user.token.toString())) {
                      setState(() {});
                    }
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
      // UserModel user = ;
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
                  // Navigator.pushNamed(context, '/p-edit').then((value) async {
                  //   await authProvider
                  //       .getCurrentUser(authProvider.user.token.toString());
                  //   setState(() {});
                  // });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        authProvider.currentUser,
                      ),
                    ),
                  ).then((value) async {
                    await authProvider
                        .getCurrentUser(authProvider.user.token.toString());
                    setState(() {});
                  });
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
              authProvider.user.level == 'admin'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    )
                  : SizedBox(
                      height: 2,
                    ),
            ],
          ),
        ),
      );
    }

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
                Navigator.pushNamed(context, '/daftar').then((value) async {
                  setState(() {});
                });
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
                Navigator.pushNamed(context, '/login').then((value) async {
                  setState(() {});
                });
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
          // Container(
          //   height: 44,
          //   child: TextButton(
          //     onPressed: () {
          //       // apiTest();
          //       // Navigator.pushNamed(context, '/login');
          //       setState(() {
          //         // flag = true;
          //         authProvider.logStatus(true);
          //       });
          //     },
          //     child: Text(
          //       'Halaman Profile',
          //       style:
          //           whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          //     ),
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 24,
          //       ),
          //       backgroundColor: Colors.blueAccent,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //   ),
          // ),
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

  Future apiTest() async {
    print('test api');
    var baseUrl = '${ApiConfig.getUrl()}/test/';
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Api Berhasil');
      print(response.body);
    } else {
      print(response.body);
      print('Api Gagal');
    }
  }
}
