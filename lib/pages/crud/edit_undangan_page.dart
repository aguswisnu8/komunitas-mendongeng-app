import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/undangan_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/add_mendongeng_from_undangan_page.dart';
import 'package:kom_mendongeng/pages/profile/user_undangan_page.dart';
import 'package:kom_mendongeng/pages/widget/loding_button.dart';
import 'package:kom_mendongeng/providers/undangan_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class EditUndanganPage extends StatefulWidget {
  // late final Map products;
  late final UndanganModel undangan;
  late final UserModel user;
  EditUndanganPage(this.undangan, this.user);
  @override
  State<EditUndanganPage> createState() => _EditUndanganPageState();
}

class _EditUndanganPageState extends State<EditUndanganPage> {
  String? statusUndangan = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    statusUndangan = widget.undangan.status;
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    UndanganProvider undanganProvider = Provider.of<UndanganProvider>(context);

    editUndangan() async {
      setState(() {
        isLoading = true;
      });
      if (await undanganProvider.editStatusUndangan(
        widget.undangan.id!,
        statusUndangan.toString(),
        widget.user.token.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: primaryColor,
            content: Text(
              'Berhasil Mengubah Status Undangan',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
        if (statusUndangan == 'terima') {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddMendongengFromUndanganPage(widget.undangan),
            ),
          );
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.redAccent,
            content: Text(
              'Gagal Mengubah Status Undangan',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget headerText() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengirim :',
              style: greyTextStyle,
            ),
            Text(
              // 'Agus Wisnu Kusuma Nata',
              '${widget.undangan.pengirim}',
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
              // 'SD 2 Senyum',
              '${widget.undangan.penyelenggara}',
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
              '${widget.undangan.nmKegiatan}',
              // 'Mendongeng Bersama Kak Dekdus',
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
              '${widget.undangan.lokasi}',
              // 'Abiansemal',
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
              '${widget.undangan.tgl}',
              // '2022-2-22',
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
              '${widget.undangan.deskripsi}',
              // 'Pada suatu saat, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor.',
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
              '${widget.undangan.jenis}',
              // 'sekolah',
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
              '${widget.undangan.contact}',
              // '081234567890',
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
              if (statusUndangan != widget.undangan.status) {
                print('masuk edit');
                editUndangan();
                // if (statusUndangan == 'terima') {
                //   Navigator.pop(context);
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>
                //           AddMendongengFromUndanganPage(widget.undangan),
                //     ),
                //   );
                // }
                // Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
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
            widget.undangan.status == 'terima'
                ? SizedBox()
                : isLoading
                    ? LoadingButton()
                    : editButton(),
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
