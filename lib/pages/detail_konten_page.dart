import 'package:flutter/material.dart';
import 'package:kom_mendongeng/theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailKontenPage extends StatefulWidget {
  @override
  State<DetailKontenPage> createState() => _DetailKontenPageState();
}

class _DetailKontenPageState extends State<DetailKontenPage> {
  String? videoId = YoutubePlayer.convertUrlToId(
      'https://www.youtube.com/watch?v=nqfVoTMEosw');

  // YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: 'nqfVoTMEosw',
  //   flags: YoutubePlayerFlags(
  //     autoPlay: true,
  //     mute: false,
  //   ),
  // );

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

    print(videoId);
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

    Widget kontenImage() {
      return Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Image(
            image: AssetImage('assets/image_test.jpg'),
            height: 200,
          ),
        ),
      );
    }

    Widget kontenVideo() {
      return Center(
        child: Container(
          margin: EdgeInsets.all(16),
          width: double.infinity,
          // height: 200,
          color: primaryColor,
          // child: Text('Video'),
          child: Column(
            children: [
              YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId.toString(),
                  flags: YoutubePlayerFlags(
                    hideControls: false,
                    controlsVisibleAtStart: true,
                    autoPlay: false,
                    mute: false,
                    loop: true,
                  ),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: secondaryColor,
                // aspectRatio: ,
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                onTap: () {
                  _launchURL('https://www.youtube.com/watch?v=nqfVoTMEosw');
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Putar di Youtube",
                      style: whiteTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Icon(
                      Icons.play_arrow,
                      color: whiteTextColor,
                      size: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),


            ],
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
              'Si Kancil yang Nakal',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'artikel dongeng',
              style: greyTextStyle,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Oleh: agus wisnu dan kusuma nata',
              style: greyTextStyle,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              'Pada suatu saat, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec leo a purus tincidunt iaculis. Vestibulum et leo a tellus eleifend pulvinar. Sed consectetur sollicitudin purus non scelerisque. Nunc rhoncus massa at velit sollicitudin iaculis. Aenean dictum nec turpis eu consequat. Nunc porta congue tincidunt. Donec et condimentum dolor. Morbi nec consequat diam, eget imperdiet enim. Pellentesque nisi risus, pellentesque quis lorem et, porta volutpat massa. Duis condimentum tellus id libero volutpat sodales. Vivamus vel pulvinar tortor.',
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
          kontenImage(),
          kontenVideo(),
          content(),
          SizedBox(
            height: defaultMargin,
          ),
        ],
      ),
    );
  }
}
