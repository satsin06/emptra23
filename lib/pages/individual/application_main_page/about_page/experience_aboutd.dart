import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/experience_add.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/about_page.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/experience_card.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class ExperienceAbout extends StatefulWidget {
  const ExperienceAbout({ Key key }) : super(key: key);

  @override
  _ExperienceAboutState createState() => _ExperienceAboutState();
}

class _ExperienceAboutState extends State<ExperienceAbout> {
  GetEmployeementHistoryModel _employmentHistoryData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Experience',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: FlatButton(
                                child: Text(
                                  '+ Add',
                                  style: TextStyle(
                                      fontFamily: 'PoppinsLight', fontSize: 12),
                                ),
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ExperienceAdd()),
                                      (Route<dynamic> route) =>
                                          route is AboutPage);
                                  //  (Route<dynamic> route) => false);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ExperienceAdd()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      _employmentHistoryData == null
                          ? Container(
                              height: 300,
                              width: 300,
                              child: Image.asset(
                                'assets/images/experience.png', // and width here
                              ),
                            )
                          : _employmentHistoryData.result == null
                              ? Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.asset(
                                    'assets/images/experience.png', // and width here
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Container(
                                    height: 210.0,
                                    child: ListView.builder(
                                        itemCount: _employmentHistoryData
                                            .result.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ExperienceEditCard(
                                                              data:
                                                                  _employmentHistoryData,
                                                              index: index)));
                                            },
                                            child: Container(
                                              width: 250,
                                              child: Card(
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      17.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage: _employmentHistoryData
                                                                        .result[
                                                                            index]
                                                                        .website
                                                                        .toString() ==
                                                                    ""
                                                                ? AssetImage(
                                                                    "assets/images/experience.png")
                                                                : NetworkImage('https://logo.clearbit.com/' +
                                                                    _employmentHistoryData
                                                                        .result[
                                                                            index]
                                                                        .website
                                                                        .toString()),
                                                            radius: 25,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ),
                                                          //  SizedBox(width: 60),
                                                          _employmentHistoryData
                                                                      .result[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Pending"
                                                              ? Container(
                                                                  //color: Colors.amber[600],
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xffFBE4BB),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8))),
                                                                  // color: Colors.blue[600],
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            6.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .hourglass_top_outlined,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Color(0xffC47F00),
                                                                        ),
                                                                        Text(
                                                                          'PENDING',
                                                                          style: TextStyle(
                                                                              color: Color(0xffC47F00),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'PoppinsLight',
                                                                              fontSize: 12),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : _employmentHistoryData
                                                                          .result[
                                                                              index]
                                                                          .status
                                                                          .toString() ==
                                                                      "Approved"
                                                                  ? Container(
                                                                      //color: Colors.amber[600],
                                                                      decoration: BoxDecoration(
                                                                          color: Color(
                                                                              0xffA7F3D0),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(8))),
                                                                      // color: Colors.blue[600],
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(6.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.check_circle,
                                                                              size: 14,
                                                                              color: Colors.green,
                                                                            ),
                                                                            Text(
                                                                              'Approved',
                                                                              style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : _employmentHistoryData
                                                                              .result[index]
                                                                              .status ==
                                                                          "Rejected"
                                                                      ? Container(
                                                                          //color: Colors.amber[600],
                                                                          decoration: BoxDecoration(
                                                                              color: Color(0xffFECACA),
                                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                                          // color: Colors.blue[600],
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.cancel,
                                                                                  size: 15,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                Text(
                                                                                  'Rejected',
                                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _employmentHistoryData
                                                                .result[index]
                                                                .designation,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black87,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            _employmentHistoryData
                                                                .result[index]
                                                                .employerName
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            // '${(Moment.parse(_employmentHistoryData.result[index].from.toString()).format('MMM y'))} - ${(Moment.parse(_employmentHistoryData.result[index].to.toString()).format('MMM y'))} ',
                                                            '${_employmentHistoryData.result[index].from.toString()} - ${_employmentHistoryData.result[index].to.toString()}',
                                                            style: kForteenText,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          _employmentHistoryData
                                                                      .result[
                                                                          index]
                                                                      .status ==
                                                                  "Pending"
                                                              ? Text(
                                                                  'PENDING',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffC47F00),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          'PoppinsLight',
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              : _employmentHistoryData
                                                                          .result[
                                                                              index]
                                                                          .status ==
                                                                      "Approved"
                                                                  ? Text(
                                                                      'Approved',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff059669),
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'PoppinsLight',
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  : _employmentHistoryData
                                                                              .result[index]
                                                                              .status ==
                                                                          "Rejected"
                                                                      ? Text(
                                                                          'Rejected',
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'PoppinsLight',
                                                                              fontSize: 12),
                                                                        )
                                                                      : SizedBox(),
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