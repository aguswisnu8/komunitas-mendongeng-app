import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/widget/loding_button.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPassController = TextEditingController(text: '');
  TextEditingController cofirmPassController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    resetPassword() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.resetPassword(
        newPassController.text,
        user.token.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: primaryColor,
            content: Text(
              'Berhasil Mereset Password',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.redAccent,
            content: Text(
              'Gagal Mereset Password',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget newPassword() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Baru',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: newPassController,
                        obscureText: true,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Password Baru',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget confirmPassword() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Massukan Password sekali lagi',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: cofirmPassController,
                        obscureText: true,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Konfirmasi Password',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget resetButton() {
      // return LoadingButton();
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/home');
              // Navigator.pop(context);
              if (newPassController.text == cofirmPassController.text) {
                resetPassword();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'Confirm Password Tidak Sama',
                      style: whiteTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Reset Password',
              style:
                  whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            )),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            newPassword(),
            confirmPassword(),
            isLoading ? LoadingButton() : resetButton(),
            SizedBox(
              height: defaultMargin,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: whiteTextStyle,
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: secondaryColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: content(),
    );
  }
}
