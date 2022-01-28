import 'package:flutter/material.dart';
import 'package:kom_mendongeng/pages/crud/add_mendongeng_from_undangan_page.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditUndanganPage extends StatefulWidget {
  late final Map products;
  EditUndanganPage(this.products);
  @override
  State<EditUndanganPage> createState() => _EditUndanganPageState();
}

class _EditUndanganPageState extends State<EditUndanganPage> {
  TextEditingController tglController =
      TextEditingController(text: 'pilih tanggal');
  String? jenisKegiatan = '';
  String? statusUndangan = '';
  @override
  Widget build(BuildContext context) {
    Widget headerText() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.products['name'],
              style: greyTextStyle,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Pengirim :',
              style: greyTextStyle,
            ),
            Text(
              'Agus Wisnu Kusuma Nata',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Penyelenggara Kegiatan :',
              style: greyTextStyle,
            ),
            Text(
              'SD 2 Senyum',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Nama Kegiatan :',
              style: greyTextStyle,
            ),
            Text(
              'Mendongeng Bersama Kak Dekdus',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Lokasi :',
              style: greyTextStyle,
            ),
            Text(
              'Abiansemal',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Tanggal Kegiatan :',
              style: greyTextStyle,
            ),
            Text(
              '2022-2-22',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Deskripsi :',
              style: greyTextStyle,
            ),
            Text(
              'Pada suatu saat, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor.',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Jenis Kegiatan :',
              style: greyTextStyle,
            ),
            Text(
              'sekolah',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Kontak Pengirim :',
              style: greyTextStyle,
            ),
            Text(
              '081234567890',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      );
    }

    Widget status() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Undangan Kegiatan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('tunggu', style: blackTextStyle),
                    value: 'tunggu',
                    groupValue: statusUndangan,
                    onChanged: (String? newValue) => setState(() {
                      statusUndangan = newValue;
                      print(statusUndangan);
                    }),
                  ),
                  RadioListTile(
                    title: Text('terima', style: blackTextStyle),
                    value: 'terima',
                    groupValue: statusUndangan,
                    onChanged: (String? newValue) => setState(() {
                      statusUndangan = newValue;
                      print(statusUndangan);
                    }),
                  ),
                  RadioListTile(
                    title: Text('tolak', style: blackTextStyle),
                    value: 'tolak',
                    groupValue: statusUndangan,
                    onChanged: (String? newValue) => setState(() {
                      statusUndangan = newValue;
                      print(statusUndangan);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget editButton() {
      // return LoadingButton();
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/home');
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddMendongengFromUndanganPage(widget.products),
                ),
              );
              // handleSignUp();
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Tambah Undangan',
              style:
                  whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            )),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            headerText(),
            status(),
            editButton(),
            SizedBox(
              height: defaultMargin,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perbaharui Status Undangan',
          style: whiteTextStyle,
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: secondaryColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: content(),
    );
  }
}
