import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/anggota_model.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';

class DetailAnggotaPage extends StatefulWidget {
  late final AnggotaModel anggota;
  DetailAnggotaPage(this.anggota);

  @override
  State<DetailAnggotaPage> createState() => _DetailAnggotaPageState();
}

class _DetailAnggotaPageState extends State<DetailAnggotaPage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Container(
            // margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              // right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.chevron_left,
                      color: whiteTextColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    Widget profileImage() {
      return Center(
        child: cekImage(widget.anggota.profilePhotoPath.toString())
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  '${widget.anggota.profilePhotoPath}',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
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
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.anggota.name}',
              // 'Agus Wisnu Kusuma Nata',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.anggota.email}',
              // 'aguswisnu8@gmail.com',
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Pengalaman Mendongeng : ${cekPengalaman(widget.anggota.exp.toString())}',
              // 'Pengalaman sbg Pendendongeng : pemula',
              style: greyTextStyle,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              '${widget.anggota.deskripsi}',
              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor.',
              style: greyTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Kontak :',
              style: greyTextStyle,
            ),
            Text(
              '${widget.anggota.medsos}',
              // 'ig: aguswisnu__3',
              style: greyTextStyle,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          profileImage(),
          content(),
          SizedBox(
            height: defaultMargin,
          ),
        ],
      ),
    );
  }
}
