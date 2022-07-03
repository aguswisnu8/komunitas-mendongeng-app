import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/partisipan_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';

import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/providers/partisipan_provider.dart';

import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class UserPartisipasiPage extends StatefulWidget {
  @override
  State<UserPartisipasiPage> createState() => _UserPartisipasiPageState();
}

class _UserPartisipasiPageState extends State<UserPartisipasiPage> {
  @override
  void initState() {
    getInit();
    // TODO: implement initState
    super.initState();
  }

  List<PartisipanModel> filteredPartisipasi = [];

  getInit() async {
    await Provider.of<PartisipanProvider>(context, listen: false)
        .getPartisipans();
  }

  String filter = '';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = '';

  TextEditingController filterController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    PartisipanProvider partisipanProvider =
        Provider.of<PartisipanProvider>(context);

    List<PartisipanModel> userPartisipasi =
        partisipanProvider.getPartispanByUserId(user.id);

    filterPartisipan(String query) {
      switch (filter) {
        case 'peran':
          final result = userPartisipasi.where((x) {
            return x.peran == query;
          }).toList();
          setState(() {
            filteredPartisipasi = result;
          });
          return;
        case 'mendongeng':
          final result = userPartisipasi.where((x) {
            String mendongengName = '${x.mendongeng?.name!.toLowerCase()}';
            return mendongengName.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredPartisipasi = result;
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
            filteredPartisipasi = userPartisipasi;
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
                              filterInputStatus = true;
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

    Widget partisipasiTile(PartisipanModel partisipan) {
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
                    '${partisipan.mendongeng?.name}',
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
                  ),
                  Text(
                    '${partisipan.user?.name} sebagai ${partisipan.peran}',
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
                    showDeleteDialog(partisipan.id!,
                            '${partisipan.user?.name} pada kegiatan ${partisipan.mendongeng?.name}')
                        .then((value) async {
                      await getInit();
                      setState(() {
                        filter = '';
                        filterStatus = false;
                        filterInputStatus = false;
                        filteredPartisipasi = userPartisipasi;
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

    Widget listPartisipasi() {
      return Column(
        children: filter == ''
            ? userPartisipasi.map((item) {
                return partisipasiTile(item);
              }).toList()
            : filteredPartisipasi.map((item) {
                return partisipasiTile(item);
              }).toList(),
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
            Text(
              'Berikut daftar partisipasi anda dalam kegiatan mendongeng keliling',
              style: blackTextStyle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            filterInput(),
            Divider(
              thickness: 1,
            ),
            // Text(
            //     'filter status: $filterStatus - filtered: ${filteredPartisipasi.length}'),
            listPartisipasi(),
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
          'Daftar Partisipasi',
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
