import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kom_mendongeng/providers/konten_provider.dart';
import 'package:kom_mendongeng/providers/mendongeng_provider.dart';
import 'package:kom_mendongeng/providers/anggota_provider.dart';
import 'package:kom_mendongeng/providers/partisipan_provider.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<MendongengProvider>(context, listen: false)
        .getMendongengs();

    await Provider.of<KontenProvider>(context, listen: false).getKontens();
    await Provider.of<AnggotaProvider>(context, listen: false).getanggotas();
    await Provider.of<PartisipanProvider>(context, listen: false)
        .getPartisipans();

    Navigator.pushNamed(context, '/home');
    // Timer(
    //   Duration(seconds: 3),
    //   () => Navigator.pushNamed(context, '/home'),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/bali_mendongeng.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
