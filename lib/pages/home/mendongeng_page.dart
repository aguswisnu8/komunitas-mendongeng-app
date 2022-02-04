import 'package:flutter/material.dart';
import 'package:kom_mendongeng/pages/widget/mendongeng_card.dart';
import 'package:kom_mendongeng/pages/widget/mendongeng_tile.dart';
import 'package:kom_mendongeng/providers/mendongeng_provider.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class MendongengPage extends StatefulWidget {
  @override
  State<MendongengPage> createState() => _MendongengPageState();
}

class _MendongengPageState extends State<MendongengPage> {
  @override
  Widget build(BuildContext context) {
    MendongengProvider mendongengProvider =
        Provider.of<MendongengProvider>(context);

    Widget header() {
      return SliverAppBar(
        backgroundColor: secondaryColor,
        // floating: true,
        centerTitle: true,
        title: Text(
          'Mendongeng Keliling',
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

    Widget akanDatang() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mendongeng Keliling, merupakan sebuah kegiatan yang dilakukan oleh para sukarelawan untuk mengadakan pentas dongeng di suatu tempat. Biasanya kegiatan ini dilakukan dari permintaan masyarakat untuk mendongeng di acara mereka, seperti mendongeng di sekolah-sekolah, acara penggalangan dana, acara di sebuah mall, bahkan ada masyarakat yang mengundang pada acara ulang tahun anak mereka.',
              style: greyTextStyle.copyWith(
                  // fontWeight: medium,
                  // fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              'Mendongeng Selanjutnya',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget sudahDilakukan() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
          bottom: 10,
        ),
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            Text(
              'Keseruan Mendongeng Keliling Sebelumnya',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'melihat keseruan apa saja yang telah kami lakukan',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
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
          akanDatang(),
          Column(
            children: mendongengProvider.mendongengs
                .map(
                  (mendongeng) => commingDay(mendongeng.tgl.toString())
                      ? MendongengCard(mendongeng)
                      : SizedBox(),
                )
                .toList(),
          ),
          // MendongengCard(),
          // MendongengCard(),
          sudahDilakukan(),
          Column(
            children: mendongengProvider.mendongengs
                .map(
                  (mendongeng) => pastDay(mendongeng.tgl.toString())
                      ? MendongengCard(mendongeng)
                      : SizedBox(),
                )
                .toList(),
          ),
          // MendongengCard(),
          // MendongengCard(),
          // MendongengCard(),
          // MendongengCard(),
        ],
      ),
    );
  }
}
