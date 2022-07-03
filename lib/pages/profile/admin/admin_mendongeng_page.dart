import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/edit_mendongeng_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/providers/mendongeng_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class AdminMendongengPage extends StatefulWidget {
  @override
  State<AdminMendongengPage> createState() => _AdminMendongengPageState();
}

class _AdminMendongengPageState extends State<AdminMendongengPage> {
  int _currentSortColumn = 0;

  bool _isAscending = false;

  List<MendongengModel> filteredMendongeng = [];
  String filter = '';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = '';
  TextEditingController filterController = TextEditingController(text: '');

  getInit() async {
    await Provider.of<MendongengProvider>(context, listen: false)
        .getMendongengs();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    MendongengProvider mendongengProvider =
        Provider.of<MendongengProvider>(context);

    filterKegiatan(String query) {
      switch (filter) {
        case 'name':
          final result = mendongengProvider.mendongengs.where((x) {
            String name = '${x.name!.toLowerCase()}';
            return name.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredMendongeng = result;
          });
          return;
        case 'jenis':
          final result = mendongengProvider.mendongengs
              .where((x) => x.jenis == query)
              .toList();
          setState(() {
            filteredMendongeng = result;
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
            filteredMendongeng = mendongengProvider.mendongengs;
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
          Divider(
            thickness: 1,
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
                                hintText: 'Cari Nama Kegiatan',
                                hintStyle: greyTextStyle),
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
                            filterKegiatan(filterController.text);
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
                'Filter Jenis :',
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    filter = 'jenis';
                    activeFilterButton = 'sekolah';
                  });
                  filterKegiatan('sekolah');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'sekolah'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'sekolah',
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
                    filter = 'jenis';
                    activeFilterButton = 'baksos';
                  });
                  filterKegiatan('baksos');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'baksos'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'baksos',
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
                    filter = 'jenis';
                    activeFilterButton = 'korporat';
                  });
                  filterKegiatan('korporat');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'korporat'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'korporat',
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

    deleteMendongeng(int id) async {
      loadingDialog();
      if (await mendongengProvider.deleteMendongeng(
        id,
        authProvider.user.token.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green[400],
            content: Text(
              'Kegiatan Mendongeng berhasil dihapus',
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
              'Gagal Menghapus Kegiatan Mendongeng',
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
                    'Hapus Kegiatan',
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
                        deleteMendongeng(id);
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
            Navigator.pushNamed(context, '/add-mendongeng');
            // Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Buat Kegiatan Mendongeng',
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
          ),
        ),
      );
    }

    Widget mendongengListTile(MendongengModel mendongeng) {
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
                    '${mendongeng.name}',
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
                  ),
                  Text(
                    'Partner: ${mendongeng.partner}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Jenis Kegiatan: ${mendongeng.jenis}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Waktu: ${mendongeng.tgl}',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Lokasi: ${mendongeng.lokasi}',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditMendongengPage(mendongeng, user),
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
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDeleteDialog(mendongeng.id!,
                            '${mendongeng.name} - ${mendongeng.tgl}')
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

    Widget mendongengList() {
      return Column(
        children: filter == ''
            ? mendongengProvider.mendongengs.map((item) {
                return mendongengListTile(item);
              }).toList()
            : filteredMendongeng.map((item) {
                return mendongengListTile(item);
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
            // tableKonten(),
            filterInput(),
            mendongengList(),
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
          'Kelola Kegiatan Mendongeng',
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
