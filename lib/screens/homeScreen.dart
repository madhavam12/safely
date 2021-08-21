import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'widgets/sidebarItems.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'constant.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);

    return SideMenu(
      radius: BorderRadius.all(
        Radius.circular(1),
      ),
      closeIcon: Icon(LineAwesomeIcons.times, color: Colors.black, size: 35),
      key: _endSideMenuKey,
      background: Color(0xFFedeeef),
      type: SideMenuType.slide,
      menu: buildMenu(context, _endSideMenuKey),
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.blueAccent,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 380,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          final _state =
                                              _endSideMenuKey.currentState;

                                          if (_state.isOpened)
                                            _state.closeSideMenu();
                                          else
                                            _state.openSideMenu();
                                        },
                                        child: Icon(LineAwesomeIcons.bars,
                                            color: Colors.white, size: 40),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 15.0, top: 25),
                                      child: Text(
                                        "${DateFormat('EEEE').format(DateTime.now())}, $formatter",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "QuickSand",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 15),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "Help",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "QuickSand",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    "Tapping on help will send your location to every nearby police officer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontFamily: "QuickSand",
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            expandedHeight: 380,
          ),
          SliverFillRemaining(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "Your past help requests",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "QuickSand",
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 35),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      colors.shuffle();
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: 25,
                        ),
                        child: RequestCard(
                          bgColor: colors[0],
                          title: "On 20 May, 2021",
                          description:
                              "Requested help on 20 May when you were at Lucknow",
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

List colors = [
  kOrangeColor,
  kBlueColor,
  kYellowColor,
];

class RequestCard extends StatelessWidget {
  String title;
  String description;

  Color bgColor;

  RequestCard({this.title, this.description, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: kTitleTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              color: kTitleTextColor.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
