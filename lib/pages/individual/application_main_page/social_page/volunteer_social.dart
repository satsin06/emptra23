import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getSocialModel.dart';
import 'package:flutter_emptra/pages/individual/add/social/social_add.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/social_card.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class VolunteerSocial extends StatefulWidget {
  const VolunteerSocial({Key key}) : super(key: key);

  @override
  _VolunteerSocialState createState() => _VolunteerSocialState();
}

class _VolunteerSocialState extends State<VolunteerSocial> {
  GetSocialHistoryModel _socialData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 320),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Volunteer Service',
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
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child: Text(
                        '+ Add',
                        style:
                            TextStyle(fontFamily: 'PoppinsLight', fontSize: 12),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SocialEditPage()));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _socialData == null
                  ? Column(
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          child: Image.asset(
                            'assets/images/social.png', // and width here
                          ),
                        ),
                        Text(
                          'Add Volunteer Service',
                          style: TextStyle(
                              color: Colors.black26,
                              fontFamily: 'PoppinsNormal',
                              fontSize: 24),
                        ),
                      ],
                    )
                  : _socialData.result == null
                      ? Column(
                          children: [
                            Container(
                              height: 250,
                              width: 250,
                              child: Image.asset(
                                'assets/images/social.png', // and width here
                              ),
                            ),
                            Text(
                              'Add Volunteer Service',
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontFamily: 'PoppinsNormal',
                                  fontSize: 24),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: ListView.builder(
                                  itemCount: _socialData.result.length,
                                  shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SocialEditCard(
                                                        data: _socialData,
                                                        index: i)));
                                      },
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.indigo,
                                                radius: 22,
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "assets/images/social.png"),
                                                  radius: 22,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _socialData
                                                        .result[i].partnerName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black87,
                                                        fontFamily:
                                                            'PoppinsLight',
                                                        fontSize: 16),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                      _socialData
                                                          .result[i].helpType
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontFamily:
                                                              'PoppinsLight',
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Text(
                                                    // '${(Moment.parse(_educationHistoryData.result[index].from.toString()).format('MMM y'))} - ${(Moment.parse(_educationHistoryData.result[index].to.toString()).format('MMM y'))} ',
                                                    _socialData.result[i].date
                                                        .toString(),
                                                    style: kForteenText,
                                                  ),
                                                  // Text(
                                                  //   '${(Moment.parse(_socialData.result[index].date.toString()).format('MMM y'))}  ',
                                                  //   style:
                                                  //   kForteenText,
                                                  // ),
                                                ],
                                              ),
                                              _socialData.result[i].status ==
                                                      "Pending"
                                                  ? Container(
                                                      //color: Colors.amber[600],
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffFBE4BB),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      // color: Colors.blue[600],
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .hourglass_top_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xffC47F00),
                                                            ),
                                                            Text(
                                                              'PENDING',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffC47F00),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'PoppinsLight',
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : _socialData.result[i]
                                                              .status ==
                                                          "Approved"
                                                      ? Container(
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffA7F3D0),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                                Text(
                                                                  'Approved',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff059669),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          'PoppinsLight',
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : _socialData.result[i]
                                                                  .status ==
                                                              "Rejected"
                                                          ? Container(
                                                              //color: Colors.amber[600],
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffFECACA),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8))),
                                                              // color: Colors.blue[600],
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    Text(
                                                                      'Rejected',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'PoppinsLight',
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              //color: Colors.amber[600],
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffFBE4BB),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8))),
                                                              // color: Colors.blue[600],
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .hourglass_top_outlined,
                                                                      size: 15,
                                                                      color: Color(
                                                                          0xffC47F00),
                                                                    ),
                                                                    Text(
                                                                      'PENDING',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xffC47F00),
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'PoppinsLight',
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ],
    );
  }
}