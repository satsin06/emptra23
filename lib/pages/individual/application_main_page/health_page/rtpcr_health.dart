import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getRtpcrModel.dart';
import 'package:flutter_emptra/pages/individual/add/health/rtpcr.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class RTPCRHelth extends StatefulWidget {
  const RTPCRHelth({Key key}) : super(key: key);

  @override
  _RTPCRHelthState createState() => _RTPCRHelthState();
}

class _RTPCRHelthState extends State<RTPCRHelth> {
  GetRtpcrModel _rtpcrData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20, right: 15,
            //    top: 310
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RTPCR Report',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'PoppinsBold',
                    fontSize: 24),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _rtpcrData == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RtpcrAdd()));
                            },
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo,
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/rtpcr.png"),
                                        radius: 22,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RTPCR Booking',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          'Click to add details',
                                          style: kForteenText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RtpcrAdd()));
                            },
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo,
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/rtpcr.png"),
                                        radius: 22,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Covid Text',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Time:  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              '${_rtpcrData.result.time.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'On: ',
                                              style: kForteenText,
                                            ),
                                            Text(
                                              ' ${_rtpcrData.result.date.toString()}',
                                              style: kForteenText,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
