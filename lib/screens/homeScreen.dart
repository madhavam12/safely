import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'widgets/sidebarItems.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constant.dart';
import 'package:safely/models/boothModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safely/services/geoFlutterFireService.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
Stream reqStream = FirebaseFirestore.instance
    .collection('requests')
    .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
    .snapshots();
GeoFire geoFire = GeoFire();

class _HomeScreenState extends State<HomeScreen> {
  bool hasRequested = false;
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US')
        .format(now); // used to get current date and time
    List<String> tokensList =
        []; //used to store deviceToken of nearby police officers(in booths)
    List<String> uidsList =
        []; //used to store uids of nearby police officers(in booths)
    List<String> numbers =
        []; //used to store numbers of nearby police officers(in booths)

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
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              leading: Container(),
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
                                        margin: EdgeInsets.only(
                                            right: 15.0, top: 25),
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
                                GestureDetector(
                                  onTap: () async {
                                    loadingBar(context);
                                    try {
                                      await geoFire
                                          .triggerBoothsStream(); //starts the geoflutterfirestream
                                      setState(() {
                                        hasRequested = true;
                                      });
                                      Navigator.pop(context);
                                    } catch (e) {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: e.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Help",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "QuickSand",
                                        fontSize: 20,
                                      ),
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
                                ),
                                hasRequested
                                    ? StreamBuilder(
                                        stream: geoFire.stream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    List<DocumentSnapshot>>
                                                snapshots) {
                                          int h =
                                              0; //to keep track of the number of documents

                                          if (snapshots.connectionState ==
                                                  ConnectionState.active &&
                                              snapshots.hasData) {
                                            return ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshots.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                BoothModel booth =
                                                    BoothModel.fromJson(
                                                        snapshots.data[index]
                                                            .data());

                                                //tokens of nearby booths
                                                tokensList
                                                    .add(booth.deviceToken);

                                                numbers.add(booth
                                                    .phone); // phone numbers of booths
                                                uidsList.add(booth.userId);
                                                //user ids of nearby booths

                                                h++;
                                                if ((h ==
                                                    snapshots.data.length)) {
                                                  //adds it to firestore when the data is fetched completly
                                                  geoFire.writeGeoPoint(
                                                      numbers: numbers,
                                                      nearbyUsersUIDs: uidsList,
                                                      tokens: tokensList);

                                                  hasRequested = false;

                                                  h = 0;
                                                }
                                                return Container();
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      )
                                    : Container(),
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
                    SizedBox(height: 10),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map>>(
                        stream: reqStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return NoRequests();
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              !snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data.docs.length == 0) {
                            return NoRequests();
                          }
                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              Timestamp time =
                                  snapshot.data.docs[index].data()['timeStamp'];
                              DateTime dt = time.toDate();

                              final DateFormat formatter =
                                  new DateFormat.yMMMMd('en_US');

                              String formatted = formatter.format(dt);

                              colors.shuffle();
                              return Container(
                                margin: EdgeInsets.only(
                                  bottom: 25,
                                ),
                                child: RequestCard(
                                  bgColor: colors[0],
                                  phones: snapshot.data.docs[index]
                                      .data()['nearbyUsersNumbers'],
                                  title: "On $formatted",
                                  description:
                                      "Requested help on $formatted when you were at ${snapshot.data.docs[index].data()['address']}",
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
