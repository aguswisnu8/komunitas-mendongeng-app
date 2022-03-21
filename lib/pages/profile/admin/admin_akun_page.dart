import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/anggota_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/edit_akun_page.dart';
import 'package:kom_mendongeng/providers/anggota_provider.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class AdminAkunPage extends StatefulWidget {
  @override
  State<AdminAkunPage> createState() => _AdminAkunPageState();
}

class _AdminAkunPageState extends State<AdminAkunPage> {
  List<AnggotaModel> filteredAnggota = [];
  String filter = 'name';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterFormButton = 'name';
  String activeFilterButton = '';
  TextEditingController filterController = TextEditingController(text: '');

  getInit() async {
    await Provider.of<AnggotaProvider>(context, listen: false).getanggotas();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    AnggotaProvider anggotaProvider = Provider.of<AnggotaProvider>(context);

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

    deleteAnggota(int id) async {
      loadingDialog();
      if (await anggotaProvider.deleteAnggota(
        id,
        authProvider.user.token.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green[400],
            content: Text(
              'Akun id: $id berhasil dihapus',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.redAccent,
            content: Text(
              'Gagal Menghapus Akun id: $id',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      Navigator.pop(context);
    }

    Future<void> showDeleteDialog(int id, String name) {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: whiteTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hapus Akun id $id',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    name,
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // print('peserta');
                        deleteAnggota(id);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Hapus',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    filterFormAnggota(String query) {
      switch (filter) {
        case 'name':
          final result = anggotaProvider.anggotas.where((x) {
            String name = '${x.name!.toLowerCase()}';
            return name.contains(query.toLowerCase());
          }).toList();
          print(result.length);
          setState(() {
            filteredAnggota = result;
          });
          return;
        case 'email':
          final result = anggotaProvider.anggotas.where((x) {
            String email = '${x.email!.toLowerCase()}';
            return email.contains(query.toLowerCase());
          }).toList();
          print(result.length);
          setState(() {
            filteredAnggota = result;
          });
          return;

        default:
      }
    }

    filterLevelAnggota(String query) {
      final result =
          anggotaProvider.anggotas.where((x) => x.level == query).toList();
      setState(() {
        filteredAnggota = result;
      });
    }

    Widget filterClearButton() {
      return TextButton(
        onPressed: () {
          setState(() {
            filterStatus = false;
            filterInputStatus = false;
            filteredAnggota = anggotaProvider.anggotas;
            activeFilterButton = '';
          });
        },
        child: Text(
          'Clear Filter',
          style: whiteTextStyle,
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 4,
          ),
          backgroundColor: Colors.red[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    Widget filterInput() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Cari berdasarkan :',
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    filter = 'name';
                    activeFilterFormButton = 'name';
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterFormButton == 'name'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'name',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    filter = 'email';
                    activeFilterFormButton = 'email';
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterFormButton == 'email'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'email',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            controller: filterController,
                            style: blackTextStyle,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Cari', hintStyle: greyTextStyle),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            print('$filter');
                            setState(() {
                              // filterInputStatus = true;
                              filterStatus = true;
                              // filter = 'judul';
                            });
                            filterFormAnggota(filterController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Filter User Level:',
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    filterStatus = true;
                    activeFilterButton = 'anggota';
                  });
                  filterLevelAnggota('anggota');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'anggota'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'anggota',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    filterStatus = true;
                    activeFilterButton = 'admin';
                  });
                  filterLevelAnggota('admin');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'admin'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'admin',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
          filterStatus ? filterClearButton() : SizedBox(),
          Divider(
            thickness: 1,
          ),
        ],
      );
    }

    Widget akunListTile(AnggotaModel anggota) {
      // return Text('data');
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(width: 1, color: Color(0xffD1D1D1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${anggota.name}',
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
                  ),
                  Text(
                    'Email: ${anggota.email}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Akun level: ${anggota.level}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/edit-akun');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAkunPage(anggota, user),
                      ),
                    ).then((value) async {
                      await getInit();
                      setState(() {});
                    });
                  },
                  child: Container(
                    color: Colors.blueAccent,
                    child: Icon(
                      Icons.edit,
                      color: whiteTextColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDeleteDialog(
                            anggota.id!, '${anggota.name} | ${anggota.email}')
                        .then((value) async {
                      await getInit();
                      setState(() {});
                    });
                  },
                  child: Container(
                    color: Colors.redAccent,
                    child: Icon(
                      Icons.delete,
                      color: whiteTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget akunList() {
      return Column(
        children: filterStatus
            ? filteredAnggota.map((anggota) => akunListTile(anggota)).toList()
            : anggotaProvider.anggotas
                .map((anggota) => akunListTile(anggota))
                .toList(),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            // Text('$filterStatus'),
            // Text('${anggotaProvider.anggotas.length}'),
            filterInput(),
            akunList(),
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
          'Kelola Akun',
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
      body: RefreshIndicator(
        onRefresh: () async {
          await getInit();
          setState(() {});
        },
        child: content(),
      ),
    );
  }
}
