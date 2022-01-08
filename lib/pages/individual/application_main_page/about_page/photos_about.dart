import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getPhotos.dart';
import 'package:flutter_emptra/pages/individual/add/about/photo_add.dart';

class PhotosAbout extends StatefulWidget {
  const PhotosAbout({Key key}) : super(key: key);

  @override
  _PhotosAboutState createState() => _PhotosAboutState();
}

class _PhotosAboutState extends State<PhotosAbout> {
  GetPhotos _getPhotoData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Photos',
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
                        MaterialPageRoute(builder: (context) => PhotoAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _getPhotoData == null
            ? Column(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      'assets/images/image.png', // and width here
                    ),
                  ),
                  Text(
                    'Add Photos',
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'PoppinsNormal',
                        fontSize: 24),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  height: 200.0,
                  child: ListView.builder(
                      itemCount: _getPhotoData.result.images.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              width: 160,
                              child: Image.network(
                                  _getPhotoData.result.images[index])),
                        );
                      }),
                ),
              ),
      ],
    );
  }
}
