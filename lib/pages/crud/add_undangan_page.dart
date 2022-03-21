import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/undangan_model.dart';
import 'package:kom_mendongeng/pages/widget/loding_button.dart';
import 'package:kom_mendongeng/providers/auth_provider.dart';
import 'package:kom_mendongeng/providers/undangan_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AddUndanganPage extends StatefulWidget {
  @override
  State<AddUndanganPage> createState() => _AddUndanganPageState();
}

class _AddUndanganPageState extends State<AddUndanganPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController lokasiController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  TextEditingController tglController =
      TextEditingController(text: 'pilih tanggal');
  TextEditingController pengirimController = TextEditingController(text: '');
  TextEditingController penyelenggaraController =
      TextEditingController(text: '');
  TextEditingController contactController = TextEditingController(text: '');

  String? jenisKegiatan = '';
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UndanganProvider undanganProvider = Provider.of<UndanganProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddUndangan() async {
      // print(nameController.text);
      // print(pengirimController.text);
      // print(penyelenggaraController.text);
      // print(deskripsiController.text);
      // print(jenisKegiatan);
      // print(lokasiController.text);
      // print(tglController.text);
      // print(contactController.text);
      setState(() {
        isLoading = true;
      });
      if (await undanganProvider.addUndangan(
        nmKegiatan: nameController.text,
        pengirim: pengirimController.text,
        lokasi: lokasiController.text,
        tgl: tglController.text,
        deskripsi: deskripsiController.text,
        jenis: jenisKegiatan,
        penyelenggara: penyelenggaraController.text,
        contact: contactController.text,
        status: 'tunggu',
        token: authProvider.user.token,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: primaryColor,
            content: Text(
              'Berhasil Mengirimkan Undangan',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.redAccent,
            content: Text(
              'Gagal Mengirimkan Undangan',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Future<void> showDetailJenis() {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: secondaryColor,
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
                    'Prosedur Undangan Bali Mendongeng',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    '• pertama utk undangan acara non profit seperti bakti sosial, pengabdian masyarakat, kami gak kenakan biaya sama sekali, karna ini sdh mnjadi komitmen kami',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '• kedua kalau utk undangan acara profit, seperti undangan dr Perusahaan utk di kegiatanya, km minta uang akomodasi, sekaligus utk  kas komunitas kami',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '• ketiga kalau utk undangan ke sekolah2 kami bisa meminta sejumlah buku/alat tulis yg nanti nya akan kami sumbangkan ke adik adik yg membutuhkan. Beserta sekedar uang transpot utk anggota km yg dtg kesana nantinya',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  isLoading ? LoadingButton() : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget namaKegiatan() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Kegiatan Undangan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
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
                        controller: nameController,
                        style: blackTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        // autovalidateMode: ,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Nama Kegiatan',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget pengirim() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengirim',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
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
                        controller: pengirimController,
                        style: blackTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Nama Pengirim',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget penyelenggara() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama/Instansi Pengelenggara',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
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
                        controller: penyelenggaraController,
                        style: blackTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Nama/Instansi Pengelenggara',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget lokasi() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Kegiatan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
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
                        controller: lokasiController,
                        style: blackTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Alamat Kegiatan',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget tgl() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tangal Pelaksanaan',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              ' tekan untuk memilih tgl',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: backgroundColor,
                ),
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2050, 12, 12),
                    onChanged: (date) {
                      print('change $date');
                    },
                    onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        tglController.text =
                            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                      });
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: Text(
                  tglController.text,
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget deskripsi() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              // height: 100,
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
                        maxLines: 8,
                        controller: deskripsiController,
                        keyboardType: TextInputType.multiline,
                        style: blackTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Deskripsi Kegiatan ',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget jenis() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showDetailJenis();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Detail Jenis Undangan',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('sekolah', style: blackTextStyle),
                    value: 'sekolah',
                    groupValue: jenisKegiatan,
                    onChanged: (String? newValue) => setState(() {
                      jenisKegiatan = newValue;
                      print(jenisKegiatan);
                    }),
                  ),
                  RadioListTile(
                    title: Text('baksos', style: blackTextStyle),
                    // subtitle: Text(
                    //   'dasdads',
                    //   style: greyTextStyle,
                    // ),
                    value: 'baksos',
                    groupValue: jenisKegiatan,
                    onChanged: (String? newValue) => setState(() {
                      jenisKegiatan = newValue;
                      print(jenisKegiatan);
                    }),
                  ),
                  RadioListTile(
                    title: Text('korporat', style: blackTextStyle),
                    value: 'korporat',
                    groupValue: jenisKegiatan,
                    onChanged: (String? newValue) => setState(() {
                      jenisKegiatan = newValue;
                      print(jenisKegiatan);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget contact() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kontak Narahubung',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Text(
              'nomor atau media yang dapat dihubungi',
              style: greyTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 6,
            ),
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
                        controller: contactController,
                        style: blackTextStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Kontak',
                            hintStyle: greyTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget addButton() {
      // return LoadingButton();
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/home');
              // Navigator.pop(context);

              if (_formKey.currentState!.validate()) {
                handleAddUndangan();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Processing Data')),
                // );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Tambah Undangan',
              style:
                  whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            )),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  namaKegiatan(),
                  pengirim(),
                  penyelenggara(),
                  deskripsi(),
                  jenis(),
                  lokasi(),
                  tgl(),
                  contact(),
                ],
              ),
            ),
            // namaKegiatan(),
            // pengirim(),
            // penyelenggara(),
            // deskripsi(),
            // jenis(),
            // lokasi(),
            // tgl(),
            // contact(),
            isLoading ? LoadingButton() : addButton(),
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
          'Tambah Undangan Baru',
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
