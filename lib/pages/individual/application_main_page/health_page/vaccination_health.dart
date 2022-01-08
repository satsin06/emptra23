import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getVaccineModel.dart';
import 'package:flutter_emptra/pages/individual/add/health/health_add.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/health_card.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class VaccinationHeath extends StatefulWidget {
  const VaccinationHeath({Key key}) : super(key: key);

  @override
  _VaccinationHeathState createState() => _VaccinationHeathState();
}

class _VaccinationHeathState extends State<VaccinationHeath> {
  GetOtherVaccineModel _vaccineData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vaccination',
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
                    style: TextStyle(fontFamily: 'PoppinsLight', fontSize: 12),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HealthAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _vaccineData == null
                  ? Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/images/vaccine.png', // and width here
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ListView.builder(
                              itemCount: _vaccineData.result.length,
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
                                                HealthEditCard(
                                                    data: _vaccineData,
                                                    index: index)));
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
                                            radius: 20,
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/covi.png"),
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
                                                _vaccineData
                                                    .result[index].vaccineName
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
                                                  _vaccineData
                                                      .result[index].vaccineDose
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
                                                '${_vaccineData.result[index].vaccineDate.toString()} ',
                                                style: kForteenText,
                                              ),
                                              // Text(
                                              //   '${(Moment.parse(_vaccineData.result[index].vaccineDate.toString()).format('MMM y'))}  ',
                                              //   style: kForteenText,
                                              // ),
                                            ],
                                          ),
                                          _vaccineData.result[index].status ==
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
                                              : _vaccineData.result[index]
                                                          .status ==
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
                                                  : _vaccineData.result[index]
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
                                  ),
                                );
                              }),
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
