import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StepCounterHealth extends StatefulWidget {
  const StepCounterHealth({Key key}) : super(key: key);

  @override
  _StepCounterHealthState createState() => _StepCounterHealthState();
}

class _StepCounterHealthState extends State<StepCounterHealth> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Text(
            'Step Counter',
            style: TextStyle(
                color: Colors.black87, fontFamily: 'PoppinsBold', fontSize: 24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 20),
                        child: Center(
                          child: CircularPercentIndicator(
                            radius: 200.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: 0.7,
                            center: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total Steps",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "6000",
                                    style: TextStyle(
                                        color: Color(0xff3E66FB),
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "/9000",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Color(0xff0FE8ED),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/step1.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '16 min',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'walking',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/burn.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '6700 cal',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Burned',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/step2.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '24 min',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Running',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/path.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '2.4 km',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Distance',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
