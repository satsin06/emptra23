import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getVideoModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/video_add.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/about_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosAbout extends StatefulWidget {
  const VideosAbout({Key key}) : super(key: key);

  @override
  _VideosAboutState createState() => _VideosAboutState();
}

class _VideosAboutState extends State<VideosAbout> {
GetVideoModel _videoData;
_ytController(url) {
    return YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    );
  }

  String _ytUrl1;
  String _ytUrl2;
  String _ytUrl3;
  String _ytUrl4;
  String _ytUrl5;
  String _ytUrl6;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Videos',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'PoppinsBold',
                    fontSize: 24),
              ),
              Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                    color: Color(0xff3E66FB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: FlatButton(
                  child: Text(
                    '+ Add',
                    style: TextStyle(fontFamily: 'PoppinsLight', fontSize: 12),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VideoAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _videoData == null
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    height: 200.0,
                    child: Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/images/video.png', // and width here
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Add Videos',
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'PoppinsNormal',
                        fontSize: 24),
                  ),
                ],
              )
            : Container(
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    _ytUrl1 == null
                        ? Container()
                        : YtCardWidget(
                            controller: _ytController(_ytUrl1),
                          ),
                    _ytUrl2 == null
                        ? Container()
                        : YtCardWidget(
                            controller: _ytController(_ytUrl2),
                          ),
                    _ytUrl3 == null
                        ? Container()
                        : YtCardWidget(
                            controller: _ytController(_ytUrl3),
                          ),
                    _ytUrl4 == null
                        ? Container()
                        : YtCardWidget(
                            controller: _ytController(_ytUrl4),
                          ),
                    _ytUrl5 == null
                        ? Container()
                        : YtCardWidget(
                            controller: _ytController(_ytUrl5),
                          ),
                    _ytUrl6 == null
                        ? Container()
                        : YtCardWidget(
                            controller: _ytController(_ytUrl6),
                          ),
                  ],
                ),
              ),
      ],
    );
  }
}
