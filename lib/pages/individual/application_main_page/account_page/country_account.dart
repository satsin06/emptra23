import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getCountryModel.dart';
import 'package:flutter_emptra/pages/individual/add/account/country_add.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class CountryAccount extends StatefulWidget {
  const CountryAccount({Key key}) : super(key: key);

  @override
  _CountryAccountState createState() => _CountryAccountState();
}

class _CountryAccountState extends State<CountryAccount> {
  GetCountryListModel _countryData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Country',
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
                      MaterialPageRoute(builder: (context) => CountryAdd()));
                },
              ),
            ),
          ],
        ),
        _countryData == null
            ? Container()
            : GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CountryAdd()));
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 10, top: 20),
                        child: Text(
                          'Your Visited Country',
                          style: kForteenText,
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                            itemCount: _countryData.result.length,
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
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 6, bottom: 6, top: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _countryData.result[index].country
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
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
