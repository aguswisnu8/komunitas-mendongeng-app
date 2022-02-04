import 'package:flutter/material.dart';
import 'package:kom_mendongeng/models/mendongeng_model.dart';
import 'package:kom_mendongeng/public_function.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMendongengPage extends StatefulWidget {
  late final MendongengModel mendongeng;
  DetailMendongengPage(this.mendongeng);

  @override
  State<DetailMendongengPage> createState() => _DetailMendongengPageState();
}

class _DetailMendongengPageState extends State<DetailMendongengPage> {
  @override
  Widget build(BuildContext context) {
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
        print('berhasil');
      } else {
        // throw 'Could not launch $url';
        print('gagal');
      }
    }

    Widget header() {
      return Column(
        children: [
          Container(
            height: 250,
            // margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: defaultMargin,
            ),
            decoration: BoxDecoration(
              image: cekImage(widget.mendongeng.gambar.toString())
                  ? DecorationImage(
                      // image: AssetImage('assets/image_test.jpg'),
                      image: NetworkImage(widget.mendongeng.gambar.toString()),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: AssetImage('assets/image_test.jpg'),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.chevron_left,
                      color: whiteTextColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.mendongeng.name}',
              // 'Mendongeng Di SD 1 Punggul',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.mendongeng.tgl}',
              // '2022-02-22',
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.mendongeng.lokasi}',
              // 'Jalan Raya Punggul',
              style: greyTextStyle.copyWith(fontSize: 16),
            ),
            widget.mendongeng.gmapLink.toString().length >= 10
                ? GestureDetector(
                    onTap: () {
                      _launchURL('${widget.mendongeng.gmapLink}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Google Map',
                          style: greyTextStyle.copyWith(color: primaryColor),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.location_on_sharp,
                          color: primaryColor,
                          // size: 40,
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Divider(
              thickness: 1,
            ),
            Text(
              '${widget.mendongeng.deskripsi}',
              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor.',
              style: greyTextStyle.copyWith(fontSize: 18),
            ),
          ],
        ),
      );
    }

    Future<void> showIkutDialog() {
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
                    'Pilih Peran yang diinginkan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    'Syarat Pendongeng:',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    'max. 2 orang berpengalaman (exp: 2)',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // print('peserta');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: primaryColor,
                              content: Text(
                                'peserta',
                                style: whiteTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'perserta',
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          print('pendongeng');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: primaryColor,
                              content: Text(
                                'pendongeng',
                                style: whiteTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'pendongeng',
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget buttonIkut() {
      return Center(
        child: Container(
          // height: 50,
          width: 200,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/home');
                // Navigator.pop(context);
                showIkutDialog();
                // handleSignUp();
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Ikut Mendongeng ?',
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              )),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          content(),
          commingDay(widget.mendongeng.tgl.toString())
              ? buttonIkut()
              : SizedBox(),
        ],
      ),
    );
  }
}
