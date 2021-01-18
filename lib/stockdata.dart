import 'package:flutter/material.dart';
import 'main.dart';
import 'global.dart' as global;
import 'package:url_launcher/url_launcher.dart';
import 'package:diff_image/diff_image.dart';
import 'news.dart';
import 'quote.dart';
import 'package:google_fonts/google_fonts.dart';

var months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "June",
  "July",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];
double icondiff;
bool icondisplay = true;
bool loadImage = false;

class Stockdata extends StatefulWidget {
  @override
  _StockdataState createState() => _StockdataState();
}

class _StockdataState extends State<Stockdata> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[700],
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.bar_chart,
                  color: Colors.grey[800],
                )),
                Tab(
                    icon: Icon(
                  Icons.article,
                  color: Colors.grey[800],
                )),
              ],
            ),
            title: Text(
              "Investigeek",
              style: GoogleFonts.lato(
                  color: Colors.grey[800],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.limeAccent[700],
          ),
          body: TabBarView(
            children: [
              QuoteScreen(),
              NewsScreen(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    chkicondiff();
    // print('lol');
    // print(icondiff);
    setState(() {
      if (stockquote != null) {
        if (stockquote[0]['change'] >= 0.0) {
          global.arrow = "assets/green_up.png";
        } else {
          global.arrow = "assets/red_down.png";
        }
      }
    });
    // icondisplay = (icondiff < 1.0) ? false : true;
  }

  void chkicondiff() async {
    final firstimage = 'https://fmpcloud.io/image-stock/AMAL.jpg';
    final secondimage = stockinfo[0]['info'];
    try {
      var diff = await DiffImage.compareFromUrl(
        firstimage,
        secondimage,
        ignoreAlpha: false,
      );
      icondiff = diff.diffValue;
      setState(() {
        loadImage = true;
      });
      // print('The difference between images is: ${diff.diffValue} percent');
    } catch (e) {
      print(e);
    }
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
