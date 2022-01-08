import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getCertificateModel.dart';
import 'package:flutter_emptra/pages/individual/add/learning/certificate_add.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/certificate_card.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class CertificateLearning extends StatefulWidget {
  const CertificateLearning({Key key}) : super(key: key);

  @override
  _CertificateLearningState createState() => _CertificateLearningState();
}

class _CertificateLearningState extends State<CertificateLearning> {
  GetCertificateModel _certificateData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Certificate',
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
                          builder: (context) => CertificateAdd()));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _certificateData == null
            ? Column(
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      'assets/images/certificate.png', // and width here
                    ),
                  ),
                  Text(
                    'Add Certificate',
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'PoppinsNormal',
                        fontSize: 24),
                  ),
                ],
              )
            : _certificateData.result == null
                ? Column(
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        child: Image.asset(
                          'assets/images/certificate.png', // and width here
                        ),
                      ),
                      Text(
                        'Add Certificate',
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
                            itemCount: _certificateData.result.length,
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CertificateEditCard(
                                                    data: _certificateData,
                                                    index: index)));
                                    // LearnEditCard(
                                    //     data:
                                    //     socialData[i])));
                                  },
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
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
                                                  "assets/images/certificate.png"),
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
                                                _certificateData.result[index]
                                                    .organizationName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsLight',
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  _certificateData.result[index]
                                                      .certificateName
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          'PoppinsLight',
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Text(
                                                '${_certificateData.result[index].dateFrom.toString()} -${_certificateData.result[index].dateTo.toString()} ',
                                                style: kForteenText,
                                              ),
                                            ],
                                          ),
                                          _certificateData.result[index].status
                                                      .toString() ==
                                                  "Pending"
                                              ? Container(
                                                  //color: Colors.amber[600],
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFBE4BB),
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
                                                          color:
                                                              Color(0xffC47F00),
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
                                              : _certificateData
                                                          .result[index].status
                                                          .toString() ==
                                                      "Approved"
                                                  ? Container(
                                                      //color: Colors.amber[600],
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffA7F3D0),
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
                                                                  .check_circle,
                                                              size: 14,
                                                              color:
                                                                  Colors.green,
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
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : _certificateData
                                                              .result[index]
                                                              .status
                                                              .toString() ==
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
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.cancel,
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
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
      ],
    );
  }
}
