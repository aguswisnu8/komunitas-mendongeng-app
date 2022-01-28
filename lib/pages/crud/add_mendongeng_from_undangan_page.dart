import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddMendongengFromUndanganPage extends StatefulWidget {
  late final Map products;
  AddMendongengFromUndanganPage(this.products);
  @override
  State<AddMendongengFromUndanganPage> createState() => _AddMendongengFromUndanganPageState();
}

class _AddMendongengFromUndanganPageState extends State<AddMendongengFromUndanganPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController lokasiController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  TextEditingController tglController =
      TextEditingController(text: 'pilih tanggal');
  TextEditingController partnerController = TextEditingController(text: '');
  TextEditingController gmapController = TextEditingController(text: '');
  TextEditingController expReqController = TextEditingController(text: '');
  TextEditingController stReqController = TextEditingController(text: '');
  // image picker
  var _image;
  var imagePicker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = new ImagePicker();
  }

  String? jenisKegiatan = '';
  @override
  Widget build(BuildContext context) {
    Widget namaKegiatan() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Kegiatan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Nama Kegiatan',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget partner() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama/Instansi Partner Kegiatan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: partnerController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Nama/Instansi Partner Kegiatan',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget lokasi() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Kegiatan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: lokasiController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Alamat Kegiatan',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget gambar() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gambar Sampul Kegiatan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: backgroundColor),
                    child: _image != null
                        ? Image.file(
                            _image,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(color: backgroundColor),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                            ),
                          ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: backgroundColor,
                    ),
                    onPressed: () async {
                      // XFile count error but it doesnt
                      final XFile? image = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      // print(image!.path);
                      setState(() {
                        _image = File(image!.path);
                      });
                      print('isi file _image $_image');
                      // print('path _image ${_image.toString()}');
                    },
                    child: Text(
                      'Pilih Gambar',
                      style: blackTextStyle.copyWith(fontWeight: semiBold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget tgl() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tangal Pelaksanaan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              ' tekan untuk memilih tgl',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: backgroundColor,
                ),
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2050, 12, 12),
                    onChanged: (date) {
                      print('change $date');
                    },
                    onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        tglController.text =
                            '${date.year}-${date.month}-${date.day}';
                      });
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: Text(
                  tglController.text,
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget deskripsi() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              // height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 8,
                        controller: deskripsiController,
                        keyboardType: TextInputType.multiline,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Deskripsi Kegiatan ',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget jenis() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis',
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
                    title: Text('sekolah', style: blackTextStyle),
                    value: 'sekolah',
                    groupValue: jenisKegiatan,
                    onChanged: (String? newValue) => setState(() {
                      jenisKegiatan = newValue;
                      print(jenisKegiatan);
                    }),
                  ),
                  RadioListTile(
                    title: Text('baksos', style: blackTextStyle),
                    subtitle: Text(
                      'dasdads',
                      style: greyTextStyle,
                    ),
                    value: 'baksos',
                    groupValue: jenisKegiatan,
                    onChanged: (String? newValue) => setState(() {
                      jenisKegiatan = newValue;
                      print(jenisKegiatan);
                    }),
                  ),
                  RadioListTile(
                    title: Text('korporat', style: blackTextStyle),
                    value: 'korporat',
                    groupValue: jenisKegiatan,
                    onChanged: (String? newValue) => setState(() {
                      jenisKegiatan = newValue;
                      print(jenisKegiatan);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget gmapLink() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Google Map Link',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              'link lokasi kegiatan, didapatkan melalui google map',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: gmapController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Link Google Map',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget expReq() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating Pengalaman',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              'rating pengalaman pendongeng yang dibutuhkan: pemula - profesional (1-5)',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: expReqController,
                        keyboardType: TextInputType.number,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'nilai pengalaman kakak (1-5)',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget stReq() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Pendongeng',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              'jumlah pendongeng yang dibutuhkan',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: stReqController,
                        keyboardType: TextInputType.number,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Jumlah Pendongeng',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget addButton() {
      // return LoadingButton();
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/home');
            Navigator.pop(context);
            // handleSignUp();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Tambah Kegiatan',
            style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            namaKegiatan(),
            partner(),
            jenis(),
            lokasi(),
            gmapLink(),
            deskripsi(),
            gambar(),
            tgl(),
            expReq(),
            stReq(),
            addButton(),
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
          'Tambah Kegiatan Baru',
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
