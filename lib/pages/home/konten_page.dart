import 'package:flutter/material.dart';
import 'package:kom_mendongeng/pages/widget/konten_tile.dart';

import 'package:kom_mendongeng/providers/konten_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class KontenPage extends StatelessWidget {
  // const MendongengPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KontenProvider kontenProvider = Provider.of<KontenProvider>(context);
    Widget header() {
      return SliverAppBar(
        backgroundColor: secondaryColor,
        // floating: true,
        centerTitle: true,
        title: Text(
          'Konten Mendongeng',
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

    Widget subTitle() {
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
              'Berikut meruakan konten mendongeng karya para anggota komunitas bali mendongeng',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 6,
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
          subTitle(),
          Column(
            children: kontenProvider.kontens
                .map((konten) => KontenTile(konten))
                .toList(),
          ),
          // KontenTile(),
          // KontenTile(),
          // KontenTile(),
          // KontenTile(),
          // KontenTile(),
          // KontenTile(),
          SizedBox(
            height: defaultMargin,
          ),
        ],
      ),
    );
  }
}
