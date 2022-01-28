import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kom_mendongeng/theme.dart';

class EditKontenPage extends StatefulWidget {
  late final Map products;
  EditKontenPage(this.products);
  @override
  State<EditKontenPage> createState() => _EditKontenPageState();
}

class _EditKontenPageState extends State<EditKontenPage> {
  var _image;
  var imagePicker;
  // late XFile a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = new ImagePicker();
  }

  String? jenisKonten = '';
  int? statusKonten = 1;
  TextEditingController judulController =
      TextEditingController(text: 'Mendongeng Bersama Kak Dekdus');
  TextEditingController linkController =
      TextEditingController(text: 'sadasdasdasdad');
  TextEditingController deskripsiController = TextEditingController(
      text:
          'Mendongeng Bersama Kak Dekdus Mendongeng Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus ');

  @override
  Widget build(BuildContext context) {
    Widget judul() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul Konten',
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
                        controller: judulController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Judul Konten',
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
              'Gambar Sampul Konten',
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

    Widget link() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Link Video',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              'Hanya untuk konten jenis video, video silahkan diunggah diyoutube terlebih dahulu kemudian masukkan link video pada kolom dibawah',
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
                        controller: linkController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Link Youtube Video ',
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
                        maxLines: 20,
                        controller: deskripsiController,
                        keyboardType: TextInputType.multiline,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Deskripsi / Isi Konten',
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
              'Jenis Konten',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Video',
                  style: blackTextStyle.copyWith(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget pengunggah() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengunggah',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Agus Wisnu',
                  style: blackTextStyle.copyWith(fontSize: 18),
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
              'Tambah Konten',
              style:
                  whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            )),
      );
    }

    Widget activeStatus() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Aktif Akun',
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
                    title: Text(
                      'non aktif',
                      style: blackTextStyle,
                    ),
                    value: 0,
                    groupValue: statusKonten,
                    onChanged: (int? newValue) =>
                        setState(() => statusKonten = newValue),
                  ),
                  RadioListTile(
                    title: Text(
                      'aktif',
                      style: blackTextStyle,
                    ),
                    value: 1,
                    groupValue: statusKonten,
                    onChanged: (int? newValue) =>
                        setState(() => statusKonten = newValue),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            judul(),
            pengunggah(),
            gambar(),
            jenis(),
            jenisKonten == 'video' ? link() : SizedBox(),
            deskripsi(),
            activeStatus(),
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
          'Tambah Konten Baru',
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
