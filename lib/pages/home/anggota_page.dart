import 'package:flutter/material.dart';
import 'package:kom_mendongeng/pages/widget/anggota_card.dart';
import 'package:kom_mendongeng/theme.dart';

class AnggotaPage extends StatelessWidget {
  // const MendongengPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverAppBar(
        backgroundColor: secondaryColor,
        // floating: true,
        centerTitle: true,
        title: Text(
          'Anggota Komunitas Bali Mendongeng',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        pinned: true,
      );
    }

    Widget deskripsi() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          // bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mari Bertemu dengan para kakak pendongeng dari Komunitas Bali Mendongenge',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              thickness: 2,
            ),

          ],
        ),
      );
    }

    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          header(),
        ];
      },
      body: ListView(
        children: [
          deskripsi(),
          AnggotaCard(),
          AnggotaCard(),
          AnggotaCard(),
        ],
      ),
    );
  }
}
