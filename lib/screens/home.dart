import 'package:clone_vntrip/components/colors.dart';
import 'package:clone_vntrip/components/navbar.dart';
import 'package:clone_vntrip/providers/login_providers.dart';
import 'package:clone_vntrip/screens/plane_ticket/ticket_booking.dart';
import 'package:clone_vntrip/screens/profile.dart';
import 'package:clone_vntrip/screens/quick_stay.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/home_provider.dart';
import 'combo.dart';
import 'hotel/hotel.dart';
import 'login.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final homeProv = Provider.of<HomeProvider>(context);

    String? accessToken = Provider.of<LoginProvider>(context).authToken;

    PageController controller = PageController();

    List<Widget> widgets = [
      homeItem(widthScreen, heightScreen, context),
      const HotelBooking(),
      const TicketBooking(),
      accessToken == null ? const Login() : Profile()
    ];

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (int num) {
            // homeProv.changeHomePage(num);
            print('Page index: $num');
          },
          children: widgets,
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: GNav(
            rippleColor: Colors.orange,
            hoverColor: Colors.orange[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 22,
            haptic: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            duration: const Duration(milliseconds: 700),
            tabBackgroundColor: Colors.orangeAccent,
            color: Colors.grey,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Trang chủ',
              ),
              GButton(
                icon: Icons.location_city,
                text: 'Khách sạn',
              ),
              GButton(
                icon: Icons.airplane_ticket_outlined,
                text: 'Vé máy bay',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Tài khoản',
              ),
            ],
            selectedIndex: 0,
            onTabChange: (index) {
              // homeProv.changeHomePage(index);
              controller.animateToPage(index, duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
              print('Navbar index: $index');
            },
          ),
        ),
      ),
    );
  }

  Widget homeItem(double widthScreen , double heightScreen, BuildContext context) {
    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    onTapToMemuItem(String s) {
      Navigator.pushNamed(context, s);
      print("Home: $s");
    }

    return ListView(
      children: [
        SizedBox(
          height: heightScreen / 2.1,
          child: Stack(
            children: [
              Container(
                child: Image.asset("assets/images/banner_home.jpg"),
              ), // banner bg
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              height: 40,
                              child: Image.asset('assets/images/logoMain.png'),
                            ),
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        _launchURL("tel://0963266688");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.bg_contact,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                '096 326 6688',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Contact
              Positioned(
                bottom: 0,
                child: Container(
                  width: widthScreen,
                  height: heightScreen / 4,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    elevation: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      onTapToMemuItem(
                                          HotelBooking.routeName);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.asset(
                                                'assets/images/hotel.png'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 9),
                                            child: const Text(
                                              'Khách sạn',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      onTapToMemuItem(
                                          TicketBooking.routeName);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.asset(
                                                'assets/images/plane_ticket.png'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 9),
                                            child: const Text(
                                              'Vé máy bay',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold),
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
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      onTapToMemuItem(Combo.routeName);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.asset(
                                                'assets/images/combo.png'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 9),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Combo\nphòng vé',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Container(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 7),
                                                  child: Text(
                                                    '3N2Đ-2.299k',
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .grayHintText,
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      onTapToMemuItem(QuickStay.routeName);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.asset(
                                                'assets/images/quick_play.png'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 9),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Quickstay',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Container(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 7),
                                                  child: Text(
                                                    'Nghỉ theo giờ',
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .grayHintText,
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ), // menu
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 22, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Text(
                  'Ưu đãi suốt tuần',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(8)),
                height: heightScreen / 3.4,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: widthScreen,
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Image.asset(
                        'assets/images/endow_1.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: widthScreen,
                      padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                      child: Image.asset(
                        'assets/images/endow_2.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 22, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Text(
                  'Điểm đến hàng đầu',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                height: heightScreen / 3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: widthScreen / 2.3,
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: heightScreen / 3,
                              child: Image.asset(
                                'assets/images/hanoi.jpg',
                                fit: BoxFit.fitHeight,
                              )),
                          Positioned(
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                  child: const Text(
                                    'Hà Nội',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                  child: const Text('1000+ Khách sạn',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: widthScreen / 2.3,
                      margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Stack(
                        children: [
                          Container(
                              height: heightScreen / 3,
                              child: Image.asset(
                                'assets/images/da_nang.jpg',
                                fit: BoxFit.fitHeight,
                              )),
                          Positioned(
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                  child: const Text(
                                    'Đà Nẵng',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                  child: const Text('1000+ Khách sạn',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: widthScreen / 2.3,
                      padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                      child: Stack(
                        children: [
                          Container(
                              height: heightScreen / 3,
                              child: Image.asset(
                                'assets/images/hoian.jpg',
                                fit: BoxFit.fitHeight,
                              )),
                          Positioned(
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                  child: const Text(
                                    'Hội An',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                  child: const Text('1000+ Khách sạn',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}