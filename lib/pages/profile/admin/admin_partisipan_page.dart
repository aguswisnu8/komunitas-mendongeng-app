import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/models/partisipan_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/edit_partisipan_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/providers/mendongeng_provider.dart';
import 'package:kom_mendongeng/providers/partisipan_provider.dart';
import 'package:kom_mendongeng/providers/undangan_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class AdminPartisipanPage extends StatefulWidget {
  @override
  State<AdminPartisipanPage> createState() => _AdminPartisipanPageState();
}

class _AdminPartisipanPageState extends State<AdminPartisipanPage> {
  @override
  void initState() {
    getInit();
    // TODO: implement initState
    super.initState();
  }

  getInit() async {
    await Provider.of<MendongengProvider>(context, listen: false)
        .getMendongengs();

    await Provider.of<PartisipanProvider>(context, listen: false)
        .getPartisipans();
  }

  String filter = '';
  String selectedList = 'mendongeng';
  bool filterStatus = false;
  bool filterInputPartisipanStatus = false;
  String activeFilterButton = '';
  List<PartisipanModel> filteredPartisipan = [];
  List<PartisipanModel> partisipanAtMendongeng = [];
  List<MendongengModel> selectedMendongeng = [];
  List<MendongengModel> filteredMendongeng = [];

  TextEditingController filterController = TextEditingController(text: '');

  int pendongeng = 0;
  int peserta = 0;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    PartisipanProvider partisipanProvider =
        Provider.of<PartisipanProvider>(context);
    MendongengProvider mendongengProvider =
        Provider.of<MendongengProvider>(context);

    getPartispan(int id) {
      partisipanAtMendongeng =
          partisipanProvider.getPartispanByMendongengId(id);
      pendongeng = 0;
      peserta = 0;
      for (var item in partisipanAtMendongeng) {
        if (item.peran == 'pendongeng') {
          pendongeng++;
        } else {
          peserta++;
        }
      }
    }

    filterPartisipan(String query) {
      switch (filter) {
        case 'peran':
          final result = partisipanAtMendongeng.where((x) {
            return x.peran == query;
          }).toList();
          setState(() {
            filteredPartisipan = result;
          });
          return;
        case 'nama':
          final result = partisipanAtMendongeng.where((x) {
            String userName = '${x.user?.name!.toLowerCase()}';
            return userName.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredPartisipan = result;
          });
          return;
        case 'mendongeng':
          final result = mendongengProvider.mendongengs.where((x) {
            String mendongengName = '${x.name!.toLowerCase()}';
            return mendongengName.contains(query.toLowerCase());
          }).toList();
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
            filterInputPartisipanStatus = false;
            activeFilterButton = '';
            filteredPartisipan = partisipanAtMendongeng;
            filteredMendongeng = mendongengProvider.mendongengs;
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

    Widget filterInputPartisipan() {
      return Column(
        children: [
          Container(
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
                                hintText: 'Cari Nama',
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
                              filterInputPartisipanStatus = true;
                              filter = 'nama';
                            });
                            filterPartisipan(filterController.text);
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
              TextButton(
                onPressed: () {
                  setState(() {
                    filter = 'peran';
                    activeFilterButton = 'peserta';
                  });
                  filterPartisipan('peserta');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'peserta'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'peserta',
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
                    filter = 'peran';
                    activeFilterButton = 'pendongeng';
                  });
                  filterPartisipan('pendongeng');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'pendongeng'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'pendongeng',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
          filter == '' ? SizedBox() : filterClearButton(),
        ],
      );
    }

    Widget filterInputKegiatan() {
      return Column(
        children: [
          Container(
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
                              filterInputPartisipanStatus = true;
                              filter = 'mendongeng';
                            });
                            filterPartisipan(filterController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          filter == '' ? SizedBox() : filterClearButton(),
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

    deletePartisipan(int id) async {
      loadingDialog();
      if (await partisipanProvider.deletePartisipan(
        id,
        authProvider.user.token.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green[400],
            content: Text(
              'Partisipan berhasil dihapus',
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
              'Gagal Menghapus Partisipan',
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
                    'Hapus partisipan',
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
                        deletePartisipan(id);

                        // print('peserta');
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

    Widget partisipanTile(PartisipanModel partisipan) {
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
                    '${partisipan.user?.name} sebagai ${partisipan.peran}',
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditPartisipanPage(partisipan, user),
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
                    showDeleteDialog(partisipan.id!,
                            '${partisipan.user?.name} pada kegiatan ${partisipan.mendongeng?.name}')
                        .then((value) async {
                      await getInit();
                      setState(() {
                        filter = '';
                        filterStatus = false;
                        filterInputPartisipanStatus = false;
                        filteredPartisipan = partisipanProvider.partisipans;
                      });
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

    Widget mendongengListTile(MendongengModel mendongeng) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedList = 'partisipan';
            selectedMendongeng.add(mendongeng);
          });
        },
        child: Container(
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
                      '${mendongeng.name}',
                      style: blackTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 16),
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
                width: 10,
              ),
            ],
          ),
        ),
      );
    }

    Widget partisipanList() {
      getPartispan(selectedMendongeng[0].id!.toInt());
      return Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedList = 'mendongeng';
                selectedMendongeng = [];
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Pilih Kegiatan Lainnya..',
              style: whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            '${selectedMendongeng[0].name}',
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          Text(
            'Waktu: ${selectedMendongeng[0].tgl}',
            style: greyTextStyle.copyWith(),
          ),
          Text(
            'Lokasi: ${selectedMendongeng[0].lokasi}',
            style: greyTextStyle.copyWith(),
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 6,
          ),
          filterInputPartisipan(),
          SizedBox(
            height: 6,
          ),
          Column(
            children: filter == ''
                ? partisipanAtMendongeng.map((item) {
                    return partisipanTile(item);
                  }).toList()
                : filteredPartisipan.map((item) {
                    return partisipanTile(item);
                  }).toList(),
          ),
        ],
      );
    }

    Widget mendongengList() {
      return Column(
        children: [
          Text(
            'List Kegiatan Mendongeng',
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          SizedBox(
            height: 6,
          ),
          filterInputKegiatan(),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 6,
          ),
          Column(
            children: filter == 'mendongeng'
                ? filteredMendongeng
                    .map((mendongeng) => mendongengListTile(mendongeng))
                    .toList()
                : mendongengProvider.mendongengs
                    .map((mendongeng) => mendongengListTile(mendongeng))
                    .toList(),
          ),
        ],
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: defaultMargin,
            ),
            selectedList == 'partisipan' ? partisipanList() : mendongengList(),
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
          'Kelola Partisipan',
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
