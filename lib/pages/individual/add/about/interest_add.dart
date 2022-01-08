import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getInterestModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestAdd extends StatefulWidget {
  @override
  _InterestAddState createState() => _InterestAddState();
}

class _InterestAddState extends State<InterestAdd> {
  String name = "";
  TextEditingController _hobbies = TextEditingController();
  TextEditingController _musicband = TextEditingController();
  TextEditingController _tvshow = TextEditingController();
  TextEditingController _book = TextEditingController();
  TextEditingController _movie = TextEditingController();
  TextEditingController _writer = TextEditingController();
  TextEditingController _game = TextEditingController();
  TextEditingController _other = TextEditingController();
  final aboutController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;

  GetInterestHistoryModel _interestHistoryData ;

  addInterest() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "userId": userId,
      "interests": {
        "hobbies": _hobbies.text.isEmpty==true?null:_hobbies.text,
        "music": _musicband.text.isEmpty==true?null:_musicband.text,
        "tvShows": _tvshow.text.isEmpty==true?null:_tvshow.text,
        "books": _book.text.isEmpty==true?null:_book.text,
        "movies": _movie.text.isEmpty==true?null:_movie.text,
        "writers": _writer.text.isEmpty==true?null:_writer.text,
        "games": _game.text.isEmpty==true?null:_game.text,
        "others": _other.text.isEmpty==true?null:_other.text,
      }
    };

    print("${Api.addInterest}/$userId");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addInterest}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _isLoading = false;
          success("Added Successfully");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomBarIndivitual()));
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        success(response.data['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
  success(String value) {
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$value",
          style: k13Fwhite400BT,
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
  getInterest() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.interestsList}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 200) {
        setState(() {
          _isLoading = false;
          print(response.data['result']);
          print("!nterrrrrrrrrrrrrrrrrrrrrrrrrrrrrest!");
          _interestHistoryData =
              GetInterestHistoryModel.fromJson(response.data);
          _hobbies.text =_interestHistoryData.result.interests.hobbies==null?null:_interestHistoryData.result.interests.hobbies.toString();
          _musicband.text =_interestHistoryData.result.interests.music==null?null:_interestHistoryData.result.interests.music.toString();
          _movie.text =_interestHistoryData.result.interests.movies==null?null:_interestHistoryData.result.interests.movies.toString();
          _tvshow.text =_interestHistoryData.result.interests.tvShows==null?null:_interestHistoryData.result.interests.tvShows.toString();
          _book.text =_interestHistoryData.result.interests.books==null?null:_interestHistoryData.result.interests.books.toString();
          _writer.text =_interestHistoryData.result.interests.writers==null?null:_interestHistoryData.result.interests.writers.toString();
          _other.text =_interestHistoryData.result.interests.others==null?null:_interestHistoryData.result.interests.others.toString();
          _game.text =_interestHistoryData.result.interests.games==null?null:_interestHistoryData.result.interests.games.toString();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        //     getEducationHistory();
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      //   getEducationHistory();
    }
  }
  @override
  void initState() {
    super.initState();
    getInterest();
    //isworking = 'true';
    // getCustomerName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xffF8F7F3),
        child: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                             Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             BottomBarIndivitual()));
                            },
                          ),),
                          SizedBox(height: 20),
                          Text(
                            'Add Interest',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Please tell us more about your interest',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PoppinsLight',
                                fontSize: 18),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Hobbies',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _hobbies,
                            style: k22InputText,
                            decoration: InputDecoration(
                              isDense: true,
                           hintText: "Singing",
                              hintStyle: k18F87Black400HT,
                            ),
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Hobbies cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Hobbies length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Music Band',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _musicband,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Beatles",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Music cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Music length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'TV Show',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _tvshow,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "F.R.I.E.N.D",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "TV Show cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "TV Show length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Book',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _book,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Invincible",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Book cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Book length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Movie',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _movie,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Hero",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Movie cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Movie length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Writer',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _writer,
                            style: k22InputText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Chetan Bhagat",
                              hintStyle: k18F87Black400HT,
                            ),
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Writer cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Writer length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Game',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _game,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "game",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Game cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Game length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Other',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _other,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Running",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return "Other cannot be empty";
                              // } else
                                if (value.length > 20) {
                                return "Other length not more than 20 words";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                textColor: Colors.white,
                                color: Color(0xff3E66FB),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    'Save',
                                    style: k13Fwhite400BT,
                                  ),
                                ),
                                onPressed: () {
                                 // addInterest();
                                  if (_formkey.currentState.validate()) {
                                    addInterest();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
