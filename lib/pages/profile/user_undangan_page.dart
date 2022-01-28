import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class UserUndanganPage extends StatefulWidget {
  @override
  State<UserUndanganPage> createState() => _UserUndanganPageState();
}

class _UserUndanganPageState extends State<UserUndanganPage> {
  final List<Map> _products = List.generate(10, (i) {
    return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  });

  int _currentSortColumn = 0;
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
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
                    'Hapus Konten $id',
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
                              'Undangan id: $id berhasil dihapus',
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

    Widget createButton() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-undangan');
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

    Widget tableKonten() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 30,
          sortColumnIndex: _currentSortColumn,
          sortAscending: _isAscending,
          // border: ,
          columns: [
            DataColumn(label: Text('id')),
            DataColumn(label: Text('name')),
            DataColumn(
              label: Text('price'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _currentSortColumn = columnIndex;
                  _isAscending = ascending;
                  if (ascending) {
                    _products.sort((a, b) => b['price'].compareTo(a['price']));
                  } else {
                    _products.sort((a, b) => a['price'].compareTo(b['price']));
                  }
                });
              },
            ),
            DataColumn(label: Text('edit')),
          ],
          rows: _products.map((item) {
            return DataRow(cells: [
              DataCell(Text(item['id'].toString())),
              DataCell(Text(item['name'])),
              DataCell(Text(item['price'].toString())),
              DataCell(
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDeleteDialog(item['id'], item['name']);
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
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            createButton(),
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
      body: content(),
    );
  }
}
