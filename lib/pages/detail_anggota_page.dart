import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';

class DetailAnggotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Container(
            // margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              // right: defaultMargin,
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

    Widget profileImage() {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/image_profile.png',
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
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
              'Agus Wisnu Kusuma Nata',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'aguswisnu8@gmail.com',
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'ig: aguswisnu__3',
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Pengalaman sbg Pendendongeng : pemula',
              style: greyTextStyle,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor.',
              style: greyTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          profileImage(),
          content(),
          SizedBox(
            height: defaultMargin,
          ),
        ],
      ),
    );
  }
}
