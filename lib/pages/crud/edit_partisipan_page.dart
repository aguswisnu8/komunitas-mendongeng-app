import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class EditPartisipanPage extends StatefulWidget {
  late final Map products;
  EditPartisipanPage(this.products);

  @override
  _EditPartisipanPageState createState() => _EditPartisipanPageState();
}

class _EditPartisipanPageState extends State<EditPartisipanPage> {
  // int? _groupValue = 1;
  String? peran = 'peserta';
  @override
  Widget build(BuildContext context) {
    Widget headerText() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MEndongeg Bersama Kak Dekdus',
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text(
                      'Peserta',
                      style: blackTextStyle,
                    ),
                    value: 'peserta',
                    groupValue: peran,
                    onChanged: (String? newValue) => setState(() {
                      peran = newValue;
                      print(peran);
                    }),
                  ),
                  RadioListTile(
                    title: Text('Pendongeng', style: blackTextStyle),
                    value: 'pendongeng',
                    groupValue: peran,
                    onChanged: (String? newValue) => setState(() {
                      peran = newValue;
                      print(peran);
                    }),
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
              'Perbaharui Peran',
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
