import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kom_mendongeng/models/konten_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/widget/loding_button.dart';
import 'package:kom_mendongeng/providers/konten_provider.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class EditKontenPage extends StatefulWidget {
  late final KontenModel konten;
  late final UserModel user;
  EditKontenPage(this.konten, this.user);
  @override
  State<EditKontenPage> createState() => _EditKontenPageState();
}

class _EditKontenPageState extends State<EditKontenPage> {
  var _image;
  var imagePicker;
  // late XFile a;
  String? jenisKonten = '';
  String? pathGambarKonten = '';
  int? statusKonten = 1;
  TextEditingController judulController =
      TextEditingController(text: 'Mendongeng Bersama Kak Dekdus');
  TextEditingController linkController =
      TextEditingController(text: 'sadasdasdasdad');
  TextEditingController deskripsiController = TextEditingController(
      text:
          'Mendongeng Bersama Kak Dekdus Mendongeng Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus Bersama Kak Dekdus ');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = new ImagePicker();

    judulController.text = widget.konten.judul.toString();
    linkController.text = widget.konten.link.toString();
    deskripsiController.text = widget.konten.deskripsi.toString();
    jenisKonten = widget.konten.jenis;
    statusKonten = widget.konten.status;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    KontenProvider kontenProvider = Provider.of<KontenProvider>(context);

    editKonten() async {
      setState(() {
        isLoading = true;
      });
      if (linkController.text=='null') {
        linkController.text = 'https://youtu.be/XqZsoesa55w';
      }
      print(judulController.text);
      print(_image);
      print(jenisKonten);
      print(linkController.text);
      print(deskripsiController.text);
      print(statusKonten);
      
      if (_image != null) {
        print('ganti image');
        if (await kontenProvider.editKonten(
          id: widget.konten.id,
          judul: judulController.text,
          filePath: _image.path,
          link: linkController.text,
          deskripsi: deskripsiController.text,
          jenis: jenisKonten,
          status: statusKonten,
          token: widget.user.token,
        )) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: primaryColor,
              content: Text(
                'Berhasil Memperbaharui Konten',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.redAccent,
              content: Text(
                'Gagal Memperbaharui Konten',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        print('image kosong');
        if (await kontenProvider.editKonten(
          id: widget.konten.id,
          judul: judulController.text,
          link: linkController.text,
          deskripsi: deskripsiController.text,
          jenis: jenisKonten,
          status: statusKonten,
          token: widget.user.token,
        )) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: primaryColor,
              content: Text(
                'Berhasil Memperbaharui Konten',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.redAccent,
              content: Text(
                'Gagal Mengubah Konten',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
      setState(() {
        isLoading = false;
      });
    }

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
                        : cekImage(widget.konten.gambar.toString())
                            ? Image.network(
                                '${widget.konten.gambar}',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.fitHeight,
                              )
                            : Container(
                                decoration:
                                    BoxDecoration(color: backgroundColor),
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
                      pathGambarKonten = image!.path;
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
                  '${widget.konten.jenis}',
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
                  '${widget.konten.user?.name}',
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
              // String? t;
              // t = 'asdadsa';
              // print(t == null || t.isEmpty);
              // if (t != null && t.isNotEmpty) {
              //   print(t);
              // }
              // handleSignUp();
              editKonten();
              // print(widget.user.token);
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Edit Konten',
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
              'Tampilkan Konten',
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
                      'sembunyikan',
                      style: blackTextStyle,
                    ),
                    value: 0,
                    groupValue: statusKonten,
                    onChanged: (int? newValue) =>
                        setState(() => statusKonten = newValue),
                  ),
                  RadioListTile(
                    title: Text(
                      'tampilkan',
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
            isLoading ? LoadingButton() : addButton(),
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
          'Edit Konten',
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
