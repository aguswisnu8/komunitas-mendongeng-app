import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  late final UserModel currentUser;

  EditProfilePage(this.currentUser);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController =
      TextEditingController(text: 'Agus Wisnu Kusuma Nata');
  TextEditingController emailController =
      TextEditingController(text: 'aguswisnu8@gmail.com');
  TextEditingController alamatController =
      TextEditingController(text: 'Punggul');
  TextEditingController kontakController =
      TextEditingController(text: 'ig: aguswisnu__3');
  TextEditingController deskripsiController =
      TextEditingController(text: 'Aku sangat Ganteng');
  TextEditingController expController = TextEditingController(text: '1');
  // image picker
  var _image;
  var imagePicker;
  // late XFile a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = new ImagePicker();

    nameController.text = widget.currentUser.name.toString();
    emailController.text = widget.currentUser.email.toString();
    alamatController.text = widget.currentUser.alamat.toString();
    kontakController.text = widget.currentUser.medsos.toString();
    deskripsiController.text = widget.currentUser.deskripsi.toString();
    expController.text = widget.currentUser.exp.toString();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel currentUser = authProvider.currentUser;

    Future<void> loadingDialog() {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          // width: MediaQuery.of(context).size.width - (4 * defaultMargin),
          width: 200,
          child: AlertDialog(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: defaultMargin),
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: whiteTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    updateProfile() async {
      loadingDialog();
      if (_image != null) {
        if (await authProvider.updateUserProfile(
          filePath: _image.path,
          name: nameController.text,
          email: emailController.text,
          alamat: alamatController.text,
          medsos: kontakController.text,
          deskripsi: deskripsiController.text,
          exp: int.parse(expController.text),
          token: authProvider.user.token,
        )) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: primaryColor,
              content: Text(
                'Berhasil Memperbaharui Profile',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.redAccent,
              content: Text(
                'Gagal Memperbaharui Profile',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        if (await authProvider.updateUserProfile(
          name: nameController.text,
          email: emailController.text,
          alamat: alamatController.text,
          medsos: kontakController.text,
          deskripsi: deskripsiController.text,
          exp: int.parse(expController.text),
          token: authProvider.user.token,
        )) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: primaryColor,
              content: Text(
                'Berhasil Memperbaharui Profile',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.redAccent,
              content: Text(
                'Gagal Memperbaharui Profile',
                style: whiteTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pop(context);
        }
      }
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
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
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: nameController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Nama',
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

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
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
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: emailController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Alamat Email',
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

    Widget alamatInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat',
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
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: alamatController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Alamat',
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

    Widget kontakInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kontak / Media Sosial',
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
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: kontakController,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Kontak/Medsos yang dapat dihubungi',
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

    Widget deskripsiInput() {
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
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        maxLines: 8,
                        controller: deskripsiController,
                        keyboardType: TextInputType.multiline,
                        style: blackTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Deskripsi Diri Kakak',
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

    Widget expInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengalaman',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              'rating: tidak ada-pemula-sedang-menengah-profesional (1-5)',
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
                        // initialValue: 'Agus Wisnu Kusuma Nata',
                        controller: expController,
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

    Widget gambar() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: backgroundColor),
                    child: _image != null
                        ? Image.file(
                            _image,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(color: backgroundColor),
                            width: 100,
                            height: 100,
                            child: cekImage(widget.currentUser.profilePhotoPath
                                    .toString())
                                ? Image(
                                    image: NetworkImage(widget
                                        .currentUser.profilePhotoPath
                                        .toString()),
                                  )
                                : Image(
                                    image:
                                        AssetImage('assets/image_profile.png'),
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

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gambar(),
              nameInput(),
              emailInput(),
              alamatInput(),
              kontakInput(),
              deskripsiInput(),
              expInput(),
              SizedBox(
                height: defaultMargin,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
        actions: [
          IconButton(
            onPressed: () {
              // print(nameController.text);
              // print(emailController.text);
              // print(alamatController.text);
              // print(kontakController.text);
              // print(deskripsiController.text);
              // print(expController.text);
              updateProfile();
            },
            icon: Icon(
              Icons.check,
              color: secondaryColor,
            ),
          ),
        ],
      ),
      body: content(),
    );
  }
}
