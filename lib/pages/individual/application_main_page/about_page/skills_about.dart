import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getIndustrySkillModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/skill_add.dart';

class SkillsAbout extends StatefulWidget {
  const SkillsAbout({Key key}) : super(key: key);

  @override
  _SkillsAboutState createState() => _SkillsAboutState();
}

class _SkillsAboutState extends State<SkillsAbout> {
  GetIndustrySkillsHistoryModel _industrySkillsData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skills',
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SkillAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _industrySkillsData == null
            ? Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/images/skill.png', // and width here
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SkillAdd()));
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          for (var i = 0;
                              i < _industrySkillsData.result.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _industrySkillsData
                                            .result[i].industryName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 18),
                                      ),
                                      Text(
                                        _industrySkillsData.result[i].rating
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 5),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: LinearProgressIndicator(
                                      value: 0.1 *
                                          double.tryParse(_industrySkillsData
                                              .result[i].rating
                                              .toString()),
                                      minHeight: 6,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                        Color(0xff3E66FB),
                                      ),
                                      backgroundColor: Color(0xffCBD5E1),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                )),
      ],
    );
  }
}
