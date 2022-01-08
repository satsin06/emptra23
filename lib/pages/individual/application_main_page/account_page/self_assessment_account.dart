import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/basicsoftskill_editable.dart';

class SelfAssessmentAccoutn extends StatefulWidget {
  const SelfAssessmentAccoutn({Key key}) : super(key: key);

  @override
  _SelfAssessmentAccoutnState createState() => _SelfAssessmentAccoutnState();
}

class _SelfAssessmentAccoutnState extends State<SelfAssessmentAccoutn> {
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Self Assessment',
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
                  'Update',
                  style: TextStyle(fontFamily: 'PoppinsLight', fontSize: 12),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicSoftSkillEdit(
                              //  data:_personalInfoHistoryData
                              )));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _personalInfoHistoryData == null
            ? Container(
                height: 300,
                width: 300,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BasicSoftSkillEdit()));
                  },
                  child: Image.asset(
                    'assets/images/skill.png', // and width here
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicSoftSkillEdit()));
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Basic Skills',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/computerskills.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Computer Skills',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.computerSkills
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/msoffice.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Ms Office',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.msOffice
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/basicdesigning.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Basic Designing',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.basicAccounting
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/basicaccounting.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Basic Accounting',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.basicAccounting
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Text(
                              'Soft Skills',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/englishcommunication.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  English Communication',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result
                                          .softSkills
                                          .englishCommunication
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/hindicommunication.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Hindi Communication',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.softSkills.hindiCommunication
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/writingengliash.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Writing English',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.softSkills.writingEnglish
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/writinghindi.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Writing Hindi',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.softSkills.writingHindi
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
