import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/konten_model.dart';
import 'package:kom_mendongeng/pages/widget/konten_tile.dart';

import 'package:kom_mendongeng/providers/konten_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class KontenPage extends StatefulWidget {
  @override
  State<KontenPage> createState() => _KontenPageState();
}

class _KontenPageState extends State<KontenPage> {
  List<KontenModel> filteredKonten = [];
  String filter = '';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = '';
  TextEditingController filterController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    KontenProvider kontenProvider = Provider.of<KontenProvider>(context);
    List<KontenModel> kontenAktif = kontenProvider.kontens;
    filterKonten(String query) {
      switch (filter) {
        case 'judul':
          final result = kontenAktif.where((x) {
            String judul = '${x.judul!.toLowerCase()}';
            return judul.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredKonten = result;
          });
          return;
        case 'jenis':
          final result = kontenAktif.where((x) => x.jenis == query).toList();
          setState(() {
            filteredKonten = result;
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
            filteredKonten = kontenAktif;
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
                              filter = 'judul';
                            });
                            filterKonten(filterController.text);
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
                    activeFilterButton = 'artikel';
                  });
                  filterKonten('artikel');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'artikel'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'artikel',
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
                    activeFilterButton = 'video';
                  });
                  filterKonten('video');
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'video'
                      ? primaryColor
                      : greyTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'video',
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

    Widget header() {
      return SliverAppBar(
        backgroundColor: secondaryColor,
        // floating: true,
        centerTitle: true,
        title: Text(
          'Konten Dongeng',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        pinned: true,
      );
    }

    Widget subTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Konten Dongeng karya anggota Komunitas Bali Mendongeng',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget listKonten() {
      return Column(
          children: filter == ''
              ? kontenAktif.map((konten) => KontenTile(konten)).toList()
              : filteredKonten.map((konten) => KontenTile(konten)).toList());
    }

    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          header(),
        ];
      },
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<KontenProvider>(context, listen: false)
              .getKontens();
          setState(() {});
        },
        child: ListView(
          children: [
            subTitle(),
            filterInput(),
            listKonten(),
            SizedBox(
              height: defaultMargin,
            ),
          ],
        ),
      ),
    );
  }
}
