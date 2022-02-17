import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/anggota_model.dart';
import 'package:kom_mendongeng/pages/detail_anggota_page.dart';
import 'package:kom_mendongeng/public_function.dart';

import 'package:kom_mendongeng/theme.dart';

class AnggotaCard extends StatelessWidget {
  late final AnggotaModel anggota;
  AnggotaCard(this.anggota);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/d-anggota');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAnggotaPage(anggota),
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
                  child: cekImage(anggota.profilePhotoPath.toString())
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            '${anggota.profilePhotoPath}',
                            width: 180,
                            height: 180,
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
                        '${anggota.name}',
                        // 'Agus Wisnu Kusuma Nata',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${anggota.email}',
                        // 'aguswisnu8@gmail.com',
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
                        // 'ig : aguswisnu__3',
                        '${anggota.medsos}',
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
