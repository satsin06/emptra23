import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getCovideVaccineModel.dart';
import 'package:flutter_emptra/pages/individual/add/health/vaccine1add.dart';
import 'package:flutter_emptra/pages/individual/add/health/vaccine2add.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/covidVaccine.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class CovidVaccinationHealth extends StatefulWidget {
  const CovidVaccinationHealth({Key key}) : super(key: key);

  @override
  _CovidVaccinationHealthState createState() => _CovidVaccinationHealthState();
}

class _CovidVaccinationHealthState extends State<CovidVaccinationHealth> {
  GetCovidVaccineModel _covidData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20, right: 15,
            //    top: 430
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Covid Vaccination',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'PoppinsBold',
                    fontSize: 24),
              ),
            ],
          ),
        ),
        _covidData == null
            ? SizedBox()
            : _covidData.result.length == 2
                ? SizedBox()
                : _covidData.result.length == 1
                    ? _covidData.result[0].vaccineDose == 1
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 15, right: 15,
                              //    top: 350
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Vaccine2Add()));
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
                                              "assets/images/dose1.png"),
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
                                            "Vaccine name 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "Dose: 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                    : SizedBox(),
        _covidData == null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15, right: 15,
                      //    top: 350
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Vaccine1Add()));
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
                                  backgroundImage:
                                      AssetImage("assets/images/dose1.png"),
                                  radius: 22,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vaccine name 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Dose: 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15, right: 15,
                      //    top: 350
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Vaccine2Add()));
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
                                  backgroundImage:
                                      AssetImage("assets/images/dose2.png"),
                                  radius: 22,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vaccine name 2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Dose: 2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
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
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListView.builder(
                          itemCount: _covidData.result.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CovidVacinCard(
                                            data: _covidData, index: index)));
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
                                          backgroundImage: AssetImage(_covidData
                                                      .result[index]
                                                      .vaccineDose ==
                                                  1
                                              ? "assets/images/dose1.png"
                                              : "assets/images/dose2.png"),
                                          radius: 22,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _covidData.result[index].vaccineName
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
                                              _covidData
                                                  .result[index].vaccineDose
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            '${_covidData.result[index].vaccineDate.toString()} ',
                                            style: kForteenText,
                                          ),
                                        ],
                                      ),
                                      _covidData.result[index].status ==
                                              "Pending"
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFBE4BB),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .hourglass_top_outlined,
                                                      size: 15,
                                                      color: Color(0xffC47F00),
                                                    ),
                                                    Text(
                                                      'PENDING',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffC47F00),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'PoppinsLight',
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : _covidData.result[index].status ==
                                                  "Approved"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffA7F3D0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          size: 14,
                                                          color: Colors.green,
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
                                              : _covidData.result[index]
                                                          .status ==
                                                      "Rejected"
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffFECACA),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
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
                                                              color: Colors.red,
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
                                                                  fontSize: 12),
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
              ),
        // ignore: unrelated_type_equality_checks
        _covidData == null
            ? SizedBox()
            : _covidData.result.length == 2
                ? SizedBox()
                : _covidData.result.length == 1
                    ? _covidData.result[0].vaccineDose == 2
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 15, right: 15,
                              //    top: 350
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Vaccine2Add()));
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
                                              "assets/images/dose2.png"),
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
                                            "Vaccine name 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "Dose: 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                    : SizedBox(),
        SizedBox(height: 20),
      ],
    );
  }
}
