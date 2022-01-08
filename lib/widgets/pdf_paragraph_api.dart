import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_emptra/widgets/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfParagraphApi {

  // static Future<File> generate() async {
  //   GetPersonalInfoHistoryModel _personalInfoHistoryData;
  //   getProfile() async {
  //     try {
  //       SharedPreferences session = await SharedPreferences.getInstance();
  //       var userId = session.getInt("userId");
  //       var dio = Dio();
  //       var response = await dio.get(
  //         "${Api.profileInfo}/$userId",
  //         options: Options(headers: {
  //           HttpHeaders.contentTypeHeader: "application/json",
  //           "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
  //           "versionnumber": "v1"
  //         }),
  //       );
  //       if (response.statusCode == 200) {
  //         print(response.data);
  //         if (response.data['code'] == 100) {
  //           _personalInfoHistoryData =
  //               GetPersonalInfoHistoryModel.fromJson(response.data);
  //           print(_personalInfoHistoryData);
  //           //   getEducationHistory();
  //
  //         } else {}
  //       } else {}
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //
  //   hello() async {
  //     try {
  //       await getProfile();
  //       // await getEtScore();
  //       // await getHealthScore();
  //       // await getLearningScore();
  //       // await getSocialScore();
  //       // await getAmount();
  //     } catch (err) {
  //       print('Caught error: $err');
  //     }
  //   }
  //
  //   @override
  //   void initState() {
  //     hello();
  //   }
  //
  //   final pdf = Document();
  //
  //   final customFont =
  //       Font.ttf(await rootBundle.load('assets/fonts/Poppins-Black.ttf'));
  //
  //   pdf.addPage(
  //     MultiPage(
  //       build: (context) => <Widget>[
  //         SizedBox(height: 0.5 * PdfPageFormat.cm),
  //         Paragraph(
  //           text:
  //               'This is my custom font that displays also characters such as €, Ł, ...',
  //           style: TextStyle(font: customFont, fontSize: 20),
  //         ),
  //         buildCustomHeadline(),
  //         buildLink(),
  //         ...buildBulletPoints(),
  //         Header(child: Text('My Headline')),
  //         Paragraph(text: LoremText().paragraph(60)),
  //         Paragraph(text: LoremText().paragraph(60)),
  //         Paragraph(text: LoremText().paragraph(60)),
  //         Paragraph(text: LoremText().paragraph(60)),
  //         Paragraph(text: LoremText().paragraph(60)),
  //       ],
  //       footer: (context) {
  //         final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
  //
  //         return Container(
  //           alignment: Alignment.centerRight,
  //           margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
  //           child: Text(
  //             text,
  //             style: TextStyle(color: PdfColors.black),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
  // }

  static Future<File> generate() async {
    final pdf = Document();

    //final imageSvg = await rootBundle.loadString('assets/images/rectangle.png');
    final imageJpg =
    (await rootBundle.load('assets/images/pdfback.jpg')).buffer.asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
          );
        } else {
          return Container();
        }
      },
    );

    pdf.addPage(
      MultiPage(
        //pageTheme: pageTheme,
        build: (context) => [
          Image(MemoryImage(imageJpg)),
          Container(
            height: pageTheme.pageFormat.availableHeight - 9,
            child: Center(
              child: Text(
                'Foreground Text',
                style: TextStyle(color: PdfColors.white, fontSize: 48),
              ),
            ),
          ),
          //SvgImage(svg: imageSvg),
          Image(MemoryImage(imageJpg)),
          Center(
            child: ClipRRect(
              horizontalRadius: 32,
              verticalRadius: 32,
              child: Image(
                MemoryImage(imageJpg),
                width: pageTheme.pageFormat.availableWidth / 2,
              ),
            ),
          ),
        ],
      ),
    );
    return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
  }







  static Widget buildCustomHeader() => Container(
        padding: EdgeInsets.only(bottom: .1 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          children: [

            PdfLogo(),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'Create Your PDF',
              style: TextStyle(fontSize: 20, color: PdfColors.blue),
            ),
          ],
        ),
      );

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.red),
      );

  static Widget buildLink() => UrlLink(
        destination: 'https://flutter.dev',
        child: Text(
          'Go to flutter.dev',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          ),
        ),
      );

  static List<Widget> buildBulletPoints() => [
        Bullet(text: 'First Bullet'),
        Bullet(text: 'Second Bullet'),
        Bullet(text: 'Third Bullet'),
      ];
}
