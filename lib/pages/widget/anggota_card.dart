import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class AnggotaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/d-anggota');
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
          // border: Border.all(width: 1, color: Color(0xffD1D1D1)),

          // color: primaryColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xffD1D1D1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/image_profile.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
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
                        'Agus Wisnu Kusuma Nata',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'aguswisnu8@gmail.com',
                        style: greyTextStyle.copyWith(
                          fontWeight: light,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        'Kontak :',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'ig : aguswisnu__3',
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
