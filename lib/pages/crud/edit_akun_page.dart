import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class EditAkunPage extends StatefulWidget {
  late final Map products;
  EditAkunPage(this.products);

  @override
  _EditAkunPageState createState() => _EditAkunPageState();
}

class _EditAkunPageState extends State<EditAkunPage> {
  int? _groupValue = 1;
  String? userLevel = 'anggota';
  @override
  Widget build(BuildContext context) {
    Widget headerText() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agus Wisnu Kusuma Nata',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              widget.products['name'],
              style: greyTextStyle,
            ),
          ],
        ),
      );
    }

    Widget peranUser() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Peran User',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              // height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('Admin', style: blackTextStyle,),
                    value: 'admin',
                    groupValue: userLevel,
                    onChanged: (String? newValue) => setState(() {
                      userLevel = newValue;
                      print(userLevel);
                    }),
                  ),
                  RadioListTile(
                    title: Text('Anggota', style: blackTextStyle),
                    value: 'anggota',
                    groupValue: userLevel,
                    onChanged: (String? newValue) => setState(() {
                      userLevel = newValue;
                      print(userLevel);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget activeStatus() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Aktif Akun',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text(
                      'non aktif',
                      style: blackTextStyle,
                    ),
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: (int? newValue) =>
                        setState(() => _groupValue = newValue),
                  ),
                  RadioListTile(
                    title: Text(
                      'aktif',
                      style: blackTextStyle,
                    ),
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (int? newValue) =>
                        setState(() => _groupValue = newValue),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget editButton() {
      // return LoadingButton();
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/home');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Perbaharui Akun',
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
            headerText(),
            peranUser(),
            activeStatus(),
            editButton(),
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
          'Edit Peran',
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
