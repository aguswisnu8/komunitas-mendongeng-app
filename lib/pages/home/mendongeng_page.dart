import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/pages/widget/mendongeng_card.dart';
import 'package:kom_mendongeng/pages/widget/mendongeng_tile.dart';
import 'package:kom_mendongeng/providers/mendongeng_provider.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class MendongengPage extends StatefulWidget {
  @override
  State<MendongengPage> createState() => _MendongengPageState();
}

class _MendongengPageState extends State<MendongengPage> {
  List<MendongengModel> filteredMendongeng = [];
  String filter = '';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = '';
  TextEditingController filterController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    MendongengProvider mendongengProvider =
        Provider.of<MendongengProvider>(context);
    List<MendongengModel> mendongengAktif = mendongengProvider.mendongengs;

    filterKegiatan(String query) {
      switch (filter) {
        case 'name':
          final result = mendongengAktif.where((x) {
            String name = '${x.name!.toLowerCase()}';
            return name.contains(query.toLowerCase());
          }).toList();
          setState(() {
            filteredMendongeng = result;
          });
          return;
        case 'jenis':
          final result =
              mendongengAktif.where((x) => x.jenis == query).toList();
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
            filteredMendongeng = mendongengAktif;
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

    Widget header() {
      return SliverAppBar(
        backgroundColor: secondaryColor,
        // floating: true,
        centerTitle: true,
        title: Text(
          'Mendongeng Keliling',
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

    Widget akanDatang() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mendongeng Selanjutnya',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget sudahDilakukan() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
          bottom: 10,
        ),
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            Text(
              'Keseruan Mendongeng Keliling Sebelumnya',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'melihat keseruan apa saja yang telah kami lakukan',
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

    Widget defaultList() {
      return Column(
        children: [
          akanDatang(),
          Column(
            children: mendongengAktif
                .map(
                  (mendongeng) => commingDay(mendongeng.tgl.toString())
                      ? MendongengCard(mendongeng)
                      : SizedBox(),
                )
                .toList(),
          ),
          sudahDilakukan(),
          Column(
            children: mendongengAktif
                .map(
                  (mendongeng) => pastDay(mendongeng.tgl.toString())
                      ? MendongengCard(mendongeng)
                      : SizedBox(),
                )
                .toList(),
          ),
        ],
      );
    }

    Widget filteredList() {
      return Column(
        children: filteredMendongeng.map((mendongeng) {
          return MendongengCard(mendongeng);
        }).toList(),
      );
    }

    Widget subHeader() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 10,
        ),
        child: Text(
          'Mendongeng Keliling, merupakan sebuah kegiatan yang dilakukan oleh para sukarelawan untuk mengadakan pentas dongeng di suatu tempat. Biasanya kegiatan ini dilakukan dari permintaan masyarakat untuk mendongeng di acara mereka, seperti mendongeng di sekolah-sekolah, acara penggalangan dana, acara di sebuah mall, bahkan ada masyarakat yang mengundang pada acara ulang tahun anak mereka.',
          style: greyTextStyle.copyWith(),
          textAlign: TextAlign.center,
        ),
      );
    }

    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          header(),
        ];
      },
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<MendongengProvider>(context, listen: false)
              .getMendongengs();

          setState(() {});
        },
        child: ListView(
          children: [
            subHeader(),
            filterInput(),
            // filterClearButton(),
            // filterInputStatus ? filterInput() : SizedBox(),
            filter == '' ? defaultList() : filteredList(),
          ],
        ),
      ),
    );
  }
}
