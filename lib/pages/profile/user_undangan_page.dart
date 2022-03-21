import 'dart:math';

import 'package:flutter/material.dart';

import 'package:kom_mendongeng/models/undangan_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/edit_undangan_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';

import 'package:kom_mendongeng/providers/undangan_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class UserUndanganPage extends StatefulWidget {
  @override
  State<UserUndanganPage> createState() => _UserUndanganPageState();
}

class _UserUndanganPageState extends State<UserUndanganPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<UndanganProvider>(context, listen: false).getUndangans();
  }

  List<UndanganModel> filteredUndangan = [];
  String filter = '';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = '';
  TextEditingController filterController = TextEditingController(text: '');

  int _currentSortColumn = 0;
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    UndanganProvider undanganProvider = Provider.of<UndanganProvider>(context);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    List<UndanganModel> userUndangan = [];
    undanganProvider.undangans.map((e) {
      if (e.userId == user.id) {
        userUndangan.add(e);
      }
    }).toList();

    filterUndangan(String query) {
      switch (filter) {
        case 'name':
          final result = userUndangan.where((x) {
            String judul = x.nmKegiatan!.toLowerCase();
            return judul.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredUndangan = result;
          });
          return;
        case 'status':
          final result = userUndangan.where((x) => x.status == query).toList();
          setState(() {
            filteredUndangan = result;
          });
          return;
        default:
      }
    }

    Widget filterClearButton() {
      return TextButton(
        onPressed: () {
          setState(() {
            filter = '';
            filterStatus = false;
            filterInputStatus = false;
            activeFilterButton = '';
            filteredUndangan = userUndangan;
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
          Divider(
            thickness: 1,
          ),
          SizedBox(
            width: 10,
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
                            setState(() {
                              filterInputStatus = true;
                              filter = 'name';
                            });
                            filterUndangan(filterController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Filter Status :',
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    filter = 'status';
                    activeFilterButton = 'tunggu';
                  });
                  filterUndangan('tunggu');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'tunggu'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'tunggu',
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
                    filter = 'status';
                    activeFilterButton = 'terima';
                  });
                  filterUndangan('terima');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'terima'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'terima',
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
                    filter = 'status';
                    activeFilterButton = 'tolak';
                  });
                  filterUndangan('tolak');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'tolak'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'tolak',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
          filter == '' ? SizedBox() : filterClearButton(),
          Divider(
            thickness: 1,
          ),
        ],
      );
    }

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

    deleteUndangan(int id) async {
      loadingDialog();
      if (await undanganProvider.deleteUndangan(
        id,
        authProvider.user.token.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green[400],
            content: Text(
              'Undangan id: $id berhasil dihapus',
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
              'Gagal Menghapus Undangan id: $id',
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
                    'Hapus Undangan id $id',
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
                        deleteUndangan(id);
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

    Widget createButton() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-undangan').then((value) {
                getInit();
              });
              // Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Buat Undangan',
              style:
                  whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
            )),
      );
    }

    Widget listUndanganTile(UndanganModel undangan) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
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
                    '${undangan.nmKegiatan}',
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
                  ),
                  Text(
                    'Penyelenggara: ${undangan.penyelenggara}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Jenis Kegiatan: ${undangan.jenis}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Pengirim: ${undangan.user?.name}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Kontak: ${undangan.contact}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Status: ${undangan.status}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDeleteDialog(undangan.id!,
                            '${undangan.nmKegiatan} dari ${undangan.penyelenggara}')
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

    Widget listUndangan() {
      return Column(
        children: filter == ''
            ? userUndangan.map((item) {
                return listUndanganTile(item);
              }).toList()
            : filteredUndangan.map((item) {
                return listUndanganTile(item);
              }).toList(),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            createButton(),
            filterInput(),
            listUndangan(),
            // tableKonten(),
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
          'Kelola Undangan',
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
