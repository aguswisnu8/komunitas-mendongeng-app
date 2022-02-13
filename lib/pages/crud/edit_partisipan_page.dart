import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/partisipan_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';

class EditPartisipanPage extends StatefulWidget {
  // late final Map products;
  late final PartisipanModel partispan;
  late final UserModel user;
  EditPartisipanPage(this.partispan, this.user);

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
              'Kegiatan : ${widget.partispan.mendongeng?.name}',
              // 'MEndongeg Bersama Kak Dekdus',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.partispan.mendongeng?.tgl} | ${widget.partispan.mendongeng?.lokasi}',
              // widget.products['name'],
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Jumlah Mak. Pendongeng : ${widget.partispan.mendongeng?.stReq}',
              // widget.products['name'],
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Pengalaman Min. Pendongeng : ${widget.partispan.mendongeng?.expReq} | ${cekPengalaman('${widget.partispan.mendongeng?.expReq}')}',
              // widget.products['name'],
              style: greyTextStyle,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'User : ${widget.partispan.user?.name}',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.partispan.user?.email}',
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.partispan.user?.exp} : ${cekPengalaman('${widget.partispan.user?.exp}')}',
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
              'Ubah User',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
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
