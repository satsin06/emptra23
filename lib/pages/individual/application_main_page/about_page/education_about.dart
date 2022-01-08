import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getEducationModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/education_add.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/education_card.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class EducationAbout extends StatefulWidget {
  const EducationAbout({Key key}) : super(key: key);

  @override
  _EducationAboutState createState() => _EducationAboutState();
}

class _EducationAboutState extends State<EducationAbout> {
  GetEducationHistoryModel _educationHistoryData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Education',
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
                            builder: (context) => EducationAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _educationHistoryData == null
            ? Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/images/education.png', // and width here
                ),
              )
            : _educationHistoryData.result == null
                ? Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      'assets/images/education.png', // and width here
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Container(
                      height: 185.0,
                      child: ListView.builder(
                          itemCount: _educationHistoryData.result.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EducationEditCard(
                                            data: _educationHistoryData,
                                            index: index)));
                              },
                              child: Container(
                                width: 230,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: _educationHistoryData
                                                          .result[index].website
                                                          .toString() ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/images/education.png")
                                                  : NetworkImage(
                                                      'https://logo.clearbit.com/' +
                                                          _educationHistoryData
                                                              .result[index]
                                                              .website
                                                              .toString()),
                                              radius: 25,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            // SizedBox(width: 20),
                                            _educationHistoryData
                                                        .result[index].status ==
                                                    "Pending"
                                                ? Container(
                                                    //color: Colors.amber[600],
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFBE4BB),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    // color: Colors.blue[600],
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
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
                                                : _educationHistoryData
                                                            .result[index]
                                                            .status ==
                                                        "Approved"
                                                    ? Container(
                                                        //color: Colors.amber[600],
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffA7F3D0),
                                                            borderRadius:
                                                                BorderRadius
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
                                                    : _educationHistoryData
                                                                .result[index]
                                                                .status ==
                                                            "Rejected"
                                                        ? Container(
                                                            //color: Colors.amber[600],
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xffFECACA),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            // color: Colors.blue[600],
                                                            alignment: Alignment
                                                                .center,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
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
                                                        : SizedBox(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _educationHistoryData
                                                  .result[index].specialization,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              _educationHistoryData
                                                  .result[index].instituteName,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              // '${(Moment.parse(_educationHistoryData.result[index].from.toString()).format('MMM y'))} - ${(Moment.parse(_educationHistoryData.result[index].to.toString()).format('MMM y'))} ',
                                              '${_educationHistoryData.result[index].from.toString()}- ${_educationHistoryData.result[index].to.toString()}',
                                              style: kForteenText,
                                            ),
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            // Text(
                                            //   'PENDING',
                                            //   style: TextStyle(
                                            //       color: Colors.red,
                                            //       fontWeight:
                                            //           FontWeight
                                            //               .bold,
                                            //       fontFamily:
                                            //           'PoppinsLight',
                                            //       fontSize: 12),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
      ],
    );
  }
}
