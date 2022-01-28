import 'package:flutter/material.dart';
import 'package:kom_mendongeng/pages/widget/konten_tile.dart';
import 'package:kom_mendongeng/pages/widget/mendongeng_tile.dart';
import 'package:kom_mendongeng/theme.dart';

class HomePage extends StatelessWidget {
  // const MendongengPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: primaryColor,
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Komunitas',
              style: whiteTextStyle.copyWith(
                fontSize: 30,
                fontWeight: bold,
              ),
            ),
            Text(
              'Bali Mendongeng',
              style: whiteTextStyle.copyWith(
                fontSize: 30,
                fontWeight: bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bali_mendongeng.png'),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Melestarikan budaya mendongeng, mempopulerkan kegiatan mendongeng kembali dan selamatkan generasi adik-adik di sekitar kita dari "krisis tutur".',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget mendongeng() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mendongeng Selanjutnya..',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  MendongengTile(),
                  MendongengTile(),
                  MendongengTile(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }

    Widget konten() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dengarkan Cerita Kami..',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondaryColor,
                    ),
                    child: Text(
                      'telusuri',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Column(
              children: [
                SizedBox(
                  width: 16,
                ),
                KontenTile(),
                KontenTile(),
                KontenTile(),
                KontenTile(),
                KontenTile(),
              ],
            ),
          ],
        ),
      );
    }

    Widget subtitle() {
      return Container(
        color: primaryColor,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              '~~~',
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              'Komunitas Bali Mendongeng merupakan sebuah wadah bagi sekelompok anak muda yang terhimpun sejak 7 Agustus 2017 untuk melestarikan budaya mendongeng dan mempopulerkan kembali kegiatan mendongeng khususnya di Bali yang di prakarsain oleh Pande Putu Setiawan.',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              '~',
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget findMe() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: primaryColor,
        ),
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              'Temui Kami juga di',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Instagram : @balimendongeng',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'YouTube : balimedongeng',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Whatsupp : 081234567890',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '~ MARI MENDONGENG ~',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        mendongeng(),
        subtitle(),
        konten(),
        findMe(),
      ],
    );
  }
}
