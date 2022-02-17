import 'dart:math';
import 'package:flutter/material.dart';
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

  final List<Map> _products = List.generate(10, (i) {
    return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  });

  int _currentSortColumn = 0;
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    UndanganProvider undanganProvider = Provider.of<UndanganProvider>(context);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

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
              label: Text('id'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _currentSortColumn = columnIndex;
                  _isAscending = ascending;
                  if (ascending) {
                    undanganProvider.undangans
                        .sort((a, b) => b.id!.toInt().compareTo(a.id!.toInt()));
                  } else {
                    undanganProvider.undangans
                        .sort((a, b) => a.id!.toInt().compareTo(b.id!.toInt()));
                  }
                });
              },
            ),
            DataColumn(label: Text('instansi')),
            DataColumn(label: Text('kegiatan')),
            DataColumn(label: Text('jenis')),
            DataColumn(label: Text('user')),
            DataColumn(label: Text('kontak')),
            DataColumn(label: Text('status')),
            DataColumn(label: Text('edit')),
            // DataColumn(label: Text('id')),
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
          rows: undanganProvider.undangans.map((undangan) {
            return DataRow(cells: [
              DataCell(Text('${undangan.id}')),
              DataCell(Text('${undangan.penyelenggara}')),
              DataCell(Text('${undangan.nmKegiatan}')),
              DataCell(Text('${undangan.jenis}')),
              DataCell(Text('${undangan.user?.name}')),
              DataCell(Text('${undangan.contact}')),
              DataCell(Text('${undangan.status}')),
              DataCell(
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditUndanganPage(undangan, user),
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
          //               // Navigator.push(
          //               //   context,
          //               //   MaterialPageRoute(
          //               //     builder: (context) => EditUndanganPage(item),
          //               //   ),
          //               // );
          //             },
          //             child: Container(
          //               color: Colors.blueAccent,
          //               child: Icon(
          //                 Icons.edit,
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
