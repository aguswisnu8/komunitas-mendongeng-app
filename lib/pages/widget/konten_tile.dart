import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class KontenTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/d-konten');
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
        ),
        padding: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Color(0xffD1D1D1)),

          // color: primaryColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
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
                        'video dongeng',
                        overflow: TextOverflow.ellipsis,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Si Kancil',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Mendongeng Bersama Pudsfnggul Mendongeng Bersama Punggul Mendongengsda Bersama Punggul Mendongeng Bersamasdaa Punggul Mendongeng Bersaasdma Punggul Mendongeng Bersama Punggul Mendonasdgeng Bersama Punggul Mendongeng Bersama Punggul Mendongeng Bersama Punggasdul Mendongeng Bersama Punggul Mendongeng Bersama Punggul',
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
