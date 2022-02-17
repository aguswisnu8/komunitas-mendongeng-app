import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/pages/detail_mendongeng_page.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';

class MendongengTile extends StatelessWidget {
  late final MendongengModel mendongeng;
  MendongengTile(this.mendongeng);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/d-mendongeng');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMendongengPage(mendongeng),
          ),
        );
      },
      child: Container(
        width: 320,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            cekImage(mendongeng.gambar.toString())
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      mendongeng.gambar.toString(),
                      width: 320,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 320,
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/bali_mendongeng.png',
                      width: 320,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${mendongeng.tgl} - ${mendongeng.lokasi}',
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${mendongeng.name}',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
