import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/konten_model.dart';
import 'package:kom_mendongeng/pages/detail_konten_page.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';

class KontenTile extends StatelessWidget {
  late final KontenModel konten;
  KontenTile(this.konten);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/d-konten');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKontenPage(konten),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
        ),
        padding: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(width: 1, color: Color(0xffD1D1D1)),

          // color: primaryColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                cekImage(konten.gambar.toString())
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          konten.gambar.toString(),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 180,
                              height: 180,
                              color: Color(0xffD1D1D1),
                              child: Center(
                                child: Text('Can\'t Load Image'),
                              ),
                            );
                          },
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/bali_mendongeng.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${konten.jenis} dongeng',
                        overflow: TextOverflow.ellipsis,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${konten.judul}',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${konten.deskripsi}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: greyTextStyle.copyWith(
                          fontWeight: light,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Divider(
            //   thickness: 1,
            // ),
          ],
        ),
      ),
    );
  }
}
