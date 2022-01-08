import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getPhysicalBody.dart';
import 'package:flutter_emptra/pages/individual/add/health/physicalBody.dart';

class PhysicalDetailsHealth extends StatefulWidget {
  const PhysicalDetailsHealth({Key key}) : super(key: key);

  @override
  _PhysicalDetailsHealthState createState() => _PhysicalDetailsHealthState();
}

class _PhysicalDetailsHealthState extends State<PhysicalDetailsHealth> {
  GetPhysicalBodyModel _physicalBodyData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Physical Details',
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhysicalBodyAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _physicalBodyData == null
            ? Center(
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 12, right: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhysicalBodyAdd()));
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
                                          Text(
                                            'Hair Texture',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
                                          // Icon(
                                          //   Icons
                                          //       .music_note_outlined,
                                          //   size: 20,
                                          //   color: Color(
                                          //       0xff3E66FB),
                                          // ),
                                          // SizedBox(
                                          //   width: 5,
                                          // ),
                                          Text(
                                            'Bust',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
                                          // Icon(
                                          //   Icons
                                          //       .live_tv_outlined,
                                          //   size: 20,
                                          //   color: Color(
                                          //       0xff3E66FB),
                                          // ),
                                          // SizedBox(
                                          //   width: 5,
                                          // ),
                                          Text(
                                            'Hips',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
                                          Text(
                                            'Eye Color',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsBold',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 140,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
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
                                          Text(
                                            'Skin Tone',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
                                          Text(
                                            'Waist',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
                                          Text(
                                            'Hair Color',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsBold',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 140,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Shoe Size',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
                                          Text(
                                            'Identification Mark',
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
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
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
              )
            : _physicalBodyData.result == null
                ? Center(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 12, right: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhysicalBodyAdd()));
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
                                              // Icon(
                                              //   Icons.tag_faces,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Hair Texture',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].hairTexture
                                                      .toString(),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .music_note_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Bust',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].bust
                                                      .toString(),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .live_tv_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Hips',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].hips
                                                      .toString(),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              Text(
                                                'Eye Color',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              _physicalBodyData
                                                  .result[0].eyeColor
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
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
                                              // Icon(
                                              //   Icons
                                              //       .video_call_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Skin Tone',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].skinTone
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .person_outline_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Waist',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].waist
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .videogame_asset_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Hair Color',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              _physicalBodyData
                                                  .result[0].hairColor
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Icon(
                                              //   Icons
                                              //       .videogame_asset_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Shoe Size',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].shoeSize
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              Text(
                                                'Identification Mark',
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
                                                child: Text(
                                                  _physicalBodyData.result[0]
                                                      .identificationMark
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                    builder: (context) => PhysicalBodyAdd()));
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
                                              // Icon(
                                              //   Icons.tag_faces,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Hair Texture',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].hairTexture
                                                      .toString(),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .music_note_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Bust',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].bust
                                                      .toString(),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .live_tv_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Hips',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].hips
                                                      .toString(),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          'PoppinsLight',
                                                      fontSize: 16),
                                                ),
                                              ),
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
                                              Text(
                                                'Eye Color',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              _physicalBodyData
                                                  .result[0].eyeColor
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
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
                                              // Icon(
                                              //   Icons
                                              //       .video_call_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Skin Tone',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].skinTone
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .person_outline_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Waist            ',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].waist
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              // Icon(
                                              //   Icons
                                              //       .videogame_asset_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Hair Color',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsBold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              _physicalBodyData
                                                  .result[0].hairColor
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Icon(
                                              //   Icons
                                              //       .videogame_asset_outlined,
                                              //   size: 20,
                                              //   color: Color(
                                              //       0xff3E66FB),
                                              // ),
                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              Text(
                                                'Shoe Size',
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
                                                child: Text(
                                                  _physicalBodyData
                                                      .result[0].shoeSize
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
                                              Text(
                                                'Identification Mark',
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
                                                child: Text(
                                                  _physicalBodyData.result[0]
                                                      .identificationMark
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
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
        SizedBox(height: 20),
      ],
    );
  }
}
