import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPassController = TextEditingController(text: '');
  TextEditingController cofirmPassController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
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
              Navigator.pop(context);
              // handleSignUp();
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
            resetButton(),
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
