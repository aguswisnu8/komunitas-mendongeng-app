import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/user_model.dart';
import 'package:kom_mendongeng/pages/crud/edit_partisipan_page.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
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
    await Provider.of<PartisipanProvider>(context, listen: false)
        .getPartisipans();
  }

  // final List<Map> _products = List.generate(10, (i) {
  //   return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  // });

  int _currentSortColumn = 0;
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    PartisipanProvider partisipanProvider =
        Provider.of<PartisipanProvider>(context);

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
                    'Hapus data $id',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green[400],
                            content: Text(
                              'Partisipan id: $id berhasil dihapus',
                              style: whiteTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
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

    Widget tableKonten() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 30,
          sortColumnIndex: _currentSortColumn,
          sortAscending: _isAscending,
          // border: ,
          columns: [
            DataColumn(
              label: Text('id kegiatan'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _currentSortColumn = columnIndex;
                  _isAscending = ascending;
                  if (ascending) {
                    partisipanProvider.partisipans.sort((a, b) => b
                        .mendongengId!
                        .toInt()
                        .compareTo(a.mendongengId!.toInt()));
                  } else {
                    partisipanProvider.partisipans.sort((a, b) => a
                        .mendongengId!
                        .toInt()
                        .compareTo(b.mendongengId!.toInt()));
                  }
                });
              },
            ),
            DataColumn(label: Text('kegiatan')),
            DataColumn(label: Text('partisipan')),
            DataColumn(label: Text('peran')),
            DataColumn(label: Text('edit')),
            // DataColumn(label: Text('name')),
            // DataColumn(
            //   label: Text('price'),
            //   onSort: (columnIndex, ascending) {
            //     setState(() {
            //       _currentSortColumn = columnIndex;
            //       _isAscending = ascending;
            //       if (ascending) {
            //         _products.sort((a, b) => b['price'].compareTo(a['price']));
            //       } else {
            //         _products.sort((a, b) => a['price'].compareTo(b['price']));
            //       }
            //     });
            //   },
            // ),
            // DataColumn(label: Text('edit')),
          ],
          rows: partisipanProvider.partisipans.map((partisipan) {
            return DataRow(cells: [
              DataCell(Text('${partisipan.mendongengId}')),
              DataCell(Text('${partisipan.mendongeng?.name}')),
              DataCell(Text('${partisipan.user?.name}')),
              DataCell(Text('${partisipan.peran}')),
              DataCell(
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
                        );
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
                            '${partisipan.user?.name} pada kegiatan ${partisipan.mendongeng?.name}');
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
              )
            ]);
          }).toList(),
          // rows: _products.map((item) {
          //   return DataRow(cells: [
          //     DataCell(Text(item['id'].toString())),
          //     DataCell(Text(item['name'])),
          //     DataCell(Text(item['price'].toString())),
          //     DataCell(
          //       Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => EditPartisipanPage(item),
          //                 ),
          //               );
          //             },
          //             child: Container(
          //               color: Colors.blueAccent,
          //               child: Icon(
          //                 Icons.edit,
          //                 color: whiteTextColor,
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             width: 10,
          //           ),
          //           GestureDetector(
          //             onTap: () {
          //               showDeleteDialog(item['id'], item['name']);
          //             },
          //             child: Container(
          //               color: Colors.redAccent,
          //               child: Icon(
          //                 Icons.delete,
          //                 color: whiteTextColor,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ]);
          // }).toList(),
        ),
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
            tableKonten(),
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
      body: content(),
    );
  }
}
