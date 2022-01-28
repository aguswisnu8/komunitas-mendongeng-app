import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class MendongengCard extends StatelessWidget {
  // const MendongengCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/d-mendongeng');
      },
      child: Container(
        // width: 320,
        // height: 100,
        margin: EdgeInsets.only(
          right: 16,
          left: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/image_test.jpg',
                width: 360,
                height: 202,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2022-02-14 - Punggul qweqweqweqweq qweq sdsa weqwe',
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Mendongeng Bersama Punggul',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
