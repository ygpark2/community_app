import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:layout/layout.dart';
import 'package:commune_app/app/blocs/app_bloc.dart';
import 'package:commune_app/app/modules/web_home/models/menu_item.dart' as menuModel;
import 'package:commune_app/app/modules/web_home/web_home_module.dart';
import 'package:commune_app/app/shared/models/theme/theme_data.dart';

import './widget/drawer_sheet.dart';
import './widget/home_body.dart';
import './widget/navigation_bottom_bar.dart';
import './widget/navigation_side_bar.dart';
import 'home_controller.dart';

const _iconAssetLocation = 'reply/icons';
const _folderIconAssetLocation = '$_iconAssetLocation/twotone_folder.png';
const kAlwaysDisplayDrawer = BreakpointValue(xs: false, md: true);


class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {

  // AppBloc appBloc = WebHomeModule.to.get<AppBloc>();
  AppBloc appBloc = Modular.get<AppBloc>();

  // ,final _navigationDestinations = getMenuItems();

  int index = 0;

  final _folders = <String, String> {
    'Receipts': _folderIconAssetLocation,
    'Pine Elementary': _folderIconAssetLocation,
    'Taxes': _folderIconAssetLocation,
    'Vacation': _folderIconAssetLocation,
    'Mortgage': _folderIconAssetLocation,
    'Freelance': _folderIconAssetLocation,
  };

  @override
  void initState() {
    super.initState();
    // appBloc.changTheme(THEME_MODE.DARK);
    print("***************** initState *****************");
  }

  /*
  void _setMenuItems() {
    rootBundle.loadString('asset/data/menu_item.json').then((menuJson) {
      setState(() {
        menuList = new List<MenuItem>.from(
            json.decode(menuJson).map((data) => MenuItem.fromJson(data)));

        // lets print out the title property
        menuList.forEach((element) {
          print(element.textLabel);
        });
      });
    });
  }
  */

  Future<List<menuModel.MenuItem>> loadMenuItems({required BuildContext context}) async {
    try {
      String menuJson = await DefaultAssetBundle.of(context)
          .loadString("data/menu_item.json");
      List<menuModel.MenuItem> menuList = new List<menuModel.MenuItem>.from(
          json.decode(menuJson).map((data) => menuModel.MenuItem.fromJson(data)));
      return menuList;
    } catch(e) {
      print("=========== loadMenuItems Error ==========");
      print(e);
      return []; // imagine this exists
    }
  }

  void _incrementCounter() {
    setState(() {
      index++;
    });
  }

  void onIndexSelect(newIndex) {
    setState(() {
      index = newIndex;
      print(" index ===========> $index");
    });
  }

  @override
  Widget build(BuildContext context) {
    final alwaysDisplayDrawer = context.layout.breakpoint > LayoutBreakpoint.sm;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
      ),
      endDrawer: alwaysDisplayDrawer ? null : DrawerSheet(key: ValueKey('Drawer')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (context.layout.breakpoint > LayoutBreakpoint.sm) ...[
            FutureBuilder(
                future: loadMenuItems(context: context),
                builder: (BuildContext context, AsyncSnapshot<List<menuModel.MenuItem>> destinations) {
                  print(destinations);
                  print(destinations.hasData);
                  print("======== snapshot data ======");

                  if (destinations.hasData) {
                    return NavigationSideBar(
                      selectedIndex: index,
                      onIndexSelect: onIndexSelect,
                      extended: true,
                      destinations: destinations.data!,
                      folders: _folders,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            VerticalDivider(thickness: 1, width: 1),
          ],
          Expanded(key: ValueKey('HomePageBody'), child: RouterOutlet()),
          if (alwaysDisplayDrawer)
            DrawerSheet(
              key: ValueKey('Drawer'),
            ),
        ],
      ),
      bottomNavigationBar: context.layout.breakpoint < LayoutBreakpoint.md
          ? NavigationBottomBar(
        selectedIndex: index,
        onIndexSelect: onIndexSelect,
      )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: index < 2 ? _incrementCounter : null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

