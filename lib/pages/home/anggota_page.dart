import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/anggota_model.dart';
import 'package:kom_mendongeng/pages/widget/anggota_card.dart';
import 'package:kom_mendongeng/providers/anggota_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class AnggotaPage extends StatefulWidget {
  @override
  State<AnggotaPage> createState() => _AnggotaPageState();
}

class _AnggotaPageState extends State<AnggotaPage> {
  List<AnggotaModel> filteredAnggota = [];
  String filter = 'name';
  bool filterStatus = false;
  bool filterInputStatus = false;
  String activeFilterButton = 'name';
  TextEditingController filterController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AnggotaProvider anggotaProvider = Provider.of<AnggotaProvider>(context);

    List<AnggotaModel> anggotaAktif = anggotaProvider.anggotas;

    filterAnggot(String query) {
      switch (filter) {
        case 'name':
          final result = anggotaAktif.where((x) {
            String name = '${x.name!.toLowerCase()}';
            return name.contains(query.toLowerCase());
          }).toList();
          print(result.length);
          setState(() {
            filteredAnggota = result;
          });
          return;
        case 'email':
          final result = anggotaAktif.where((x) {
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

    Widget filterClearButton() {
      return TextButton(
        onPressed: () {
          setState(() {
            filterStatus = false;
            filterInputStatus = false;
            filteredAnggota = anggotaAktif;
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
                    activeFilterButton = 'name';
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'name'
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
                    activeFilterButton = 'email';
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: activeFilterButton == 'email'
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
                            filterAnggot(filterController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          filterStatus ? filterClearButton() : SizedBox(),
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
          'Anggota Komunitas Bali Mendongeng',
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

    Widget subHeader() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          // bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mari bertemu dengan para kakak pendongeng dari Komunitas Bali Mendongeng',
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

    Widget listAnggota() {
      return Column(
        children: filterStatus
            ? filteredAnggota.map((anggota) => AnggotaCard(anggota)).toList()
            : anggotaAktif.map((anggota) => AnggotaCard(anggota)).toList(),
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
          await Provider.of<AnggotaProvider>(context, listen: false)
              .getanggotas();

          setState(() {});
        },
        child: ListView(
          children: [
            subHeader(),
            filterInput(),
            // Text(
            //     'filter status: $filterStatus - filtered: ${filteredAnggota.length}'),
            listAnggota(),
            SizedBox(
              height: defaultMargin,
            )
          ],
        ),
      ),
    );
  }
}
