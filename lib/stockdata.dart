import 'package:flutter/material.dart';
import 'main.dart';
import 'global.dart' as global;
import 'package:url_launcher/url_launcher.dart';
import 'news.dart';
import 'quote.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';

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
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors
                  .grey[800], //This will change the drawer background to blue.
              //other styles
            ),
            child: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text(
                      "Investigeek",
                      style: GoogleFonts.lato(
                          color: Colors.grey[800],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.limeAccent[700],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Rate",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                    onTap: () {
                      LaunchReview.launch(
                          androidAppId: "com.rohityelnare.investigeek");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Share",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                    onTap: () {
                      Share.share(
                          'Know latest quotes and news of stocks listed on NYSE & NASDAQ!\nhttps://play.google.com/store/apps/details?id=com.rohityelnare.investigeek');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Visit My Website",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                    onTap: () {
                      launchURL("http://rohit.yelnare.com/");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.code_sharp,
                      color: Colors.white,
                    ),
                    title: Text(
                      "View Source Code",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                    onTap: () {
                      launchURL("https://github.com/RohitYelnare/Investigeek");
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Made by Rohit Yelnare",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              "Investigeek",
              style: GoogleFonts.lato(
                  color: Colors.grey[800],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
            iconTheme: IconThemeData(color: Colors.grey[800]),
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
    setState(() {
      if (stockquote != null) {
        if (stockquote[0]['change'] >= 0.0) {
          global.arrow = "assets/green_up.png";
        } else {
          global.arrow = "assets/red_down.png";
        }
      }
    });
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
