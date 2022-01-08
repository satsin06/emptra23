import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getInterestModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/interest_add.dart';

class IntrestAbout extends StatefulWidget {
  const IntrestAbout({Key key}) : super(key: key);

  @override
  _IntrestAboutState createState() => _IntrestAboutState();
}

class _IntrestAboutState extends State<IntrestAbout> {
  GetInterestHistoryModel _interestHistoryData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interests',
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
                        MaterialPageRoute(builder: (context) => InterestAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _interestHistoryData == null
            ? Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/images/interest.png', // and width here
                ),
              )
            : _interestHistoryData.result == null
                ? Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      'assets/images/interest.png', // and width here
                    ),
                  )
                : Center(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 12, right: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InterestAdd()));
                          },
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.tag_faces,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Hobbies',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .hobbies ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .hobbies
                                                            .toString(),
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(width: 8)
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.music_note_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Music Band',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .music ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .music
                                                            .toString(),
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.live_tv_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'TV Show',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .tvShows ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .tvShows
                                                            .toString(),
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.menu_book_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Book              ',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .books ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .books
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.video_call_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Movie',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .movies ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .movies
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'writer            ',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .writers ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .writers
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(width: 10)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.videogame_asset_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Game',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .games ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .games
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(width: 8)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.videogame_asset_outlined,
                                                size: 20,
                                                color: Color(0xff3E66FB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Others',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 140,
                                                child: _interestHistoryData
                                                            .result
                                                            .interests
                                                            .others ==
                                                        null
                                                    ? SizedBox(
                                                        height: 15,
                                                      )
                                                    : Text(
                                                        _interestHistoryData
                                                            .result
                                                            .interests
                                                            .others
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                              ),
                                              SizedBox(width: 8)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
      ],
    );
  }
}
