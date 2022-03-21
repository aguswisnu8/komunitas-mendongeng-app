import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/undangan_model.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/edit_undangan_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/providers/undangan_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class AdminUndanganPage extends StatefulWidget {
  @override
  State<AdminUndanganPage> createState() => _AdminUndanganPageState();
}

class _AdminUndanganPageState extends State<AdminUndanganPage> {
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  Future<void> getInit() async {
    await Provider.of<UndanganProvider>(context, listen: false).getUndangans();
  }

  int _currentSortColumn = 0;
  bool _isAscending = false;

  List<UndanganModel> filteredUndangan = [];
  String filter = '';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = '';
  TextEditingController filterController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    UndanganProvider undanganProvider = Provider.of<UndanganProvider>(context);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    filterUndangan(String query) {
      switch (filter) {
        case 'name':
          final result = undanganProvider.undangans.where((x) {
            String judul = x.nmKegiatan!.toLowerCase();
            return judul.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredUndangan = result;
          });
          return;
        case 'status':
          final result = undanganProvider.undangans
              .where((x) => x.status == query)
              .toList();
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
            filteredUndangan = undanganProvider.undangans;
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
          Text(
            'List Undangan',
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 18,
            ),
          ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUndanganPage(undangan, user),
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
              ],
            ),
          ],
        ),
      );
    }

    Widget listUndangan() {
      return Column(
        children: filter == ''
            ? undanganProvider.undangans.map((item) {
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
            SizedBox(
              height: defaultMargin,
            ),
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
