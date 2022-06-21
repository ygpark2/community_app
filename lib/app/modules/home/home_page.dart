import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:commune_app/app/modules/home/widgets/item_post.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Start"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  int currentIndex = 0;

  Map<String, List> postData = Map<String, List>();
  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = false;
    });
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget _buildDrawer(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.25,
        child: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              DrawerHeader(
                child: Container(
                    height: 142,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/ten_news.png",
                    )),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Colors.black45,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Colors.black45,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'About',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Colors.black45,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'Log Out',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Colors.black45,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 45,
              ),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'v1.0.1',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Colors.black45,
                          fontSize: 20,
                          // color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/drawer.svg",
                height: 15,
                width: 34,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        backgroundColor: currentIndex == 3 ? Color(0xffF7F8FA) : Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: _buildDrawer(context),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : <Widget>[
              ItemPost(
                postData: postData,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.green,
              ),
            ][currentIndex],
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    /*
    iconSize - the item icon's size
    items - navigation items, required more than one item and less than six
    selectedIndex - the current item index. Use this to change the selected item. Default to zero
    onItemSelected - required to listen when a item is tapped it provide the selected item's index
    backgroundColor - the navigation bar's background color
    showElevation - if false the appBar's elevation will be removed
    mainAxisAlignment - use this property to change the horizontal alignment of the items. It is mostly used when you have ony two items and you want to center the items
    curve - param to customize the item change's animation
    containerHeight - changes the Navigation Bar's height
     */
    return BottomNavyBar(
      selectedIndex: currentIndex,
      onItemSelected: changePage,
      showElevation: true,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            inactiveColor: Colors.black54,
            activeColor: Colors.black,
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 21,
              color: Colors.black54,
              height: 21,
            ),
            title: Text("Home")),
        BottomNavyBarItem(
            inactiveColor: Colors.black54,
            activeColor: Colors.black,
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 21,
              color: Colors.black54,
              height: 21,
            ),
            title: Text("Search")),
        BottomNavyBarItem(
            inactiveColor: Colors.black54,
            activeColor: Colors.black,
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              width: 21,
              color: Colors.black54,
              height: 21,
            ),
            title: Text("Bookmarks")),
        BottomNavyBarItem(
            inactiveColor: Colors.black54,
            activeColor: Colors.black,
            icon: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('assets/user.png')),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x5c000000),
                      offset: Offset(0, 1),
                      blurRadius: 5)
                ],
              ),
            ),
            title: Text("Profile")),
      ],
    );
  }
}
