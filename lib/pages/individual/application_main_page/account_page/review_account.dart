import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getAllhrDetail.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class ReviewAccount extends StatefulWidget {
  const ReviewAccount({Key key}) : super(key: key);

  @override
  _ReviewAccountState createState() => _ReviewAccountState();
}

class _ReviewAccountState extends State<ReviewAccount> {
  GetAllHrDetail _getAllHrDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Review',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'PoppinsBold',
                  fontSize: 24),
            ),
          ],
        ),
        SizedBox(height: 10),
        _getAllHrDetails == null
            ? GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             CountryAdd()));
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 10, top: 20),
                        child: Text(
                          'Please fill your hr details',
                          style: kForteenText,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ReviewSkillEdit()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListView.builder(
                          itemCount: _getAllHrDetails.result.length,
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getAllHrDetails
                                          .result[index].organizationName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Hr Name: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          _getAllHrDetails.result[index].hrName
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Review: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          _getAllHrDetails.result[index].review
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Dedication and Hardwork',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].dedicationHandwork
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index]
                                                .dedicationHandwork
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Punctuality',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].punctuality
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index].punctuality
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Team Work',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].teamWork
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index].teamWork
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Client Satisfaction',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].clientSatisfaction
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index]
                                                .clientSatisfaction
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Learning and Growth',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].learningGrowth
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index].learningGrowth
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
