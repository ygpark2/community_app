import 'package:commune_app/app/modules/web_home/models/board_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/shared/tool/alert_dialog_confirm.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';
import 'package:commune_app/app/shared/widgets/section_title.dart';
import '../../web_home_routes.dart';
import 'list_controller.dart';
import 'widget/post_item.dart';
import 'widget/flex_app_bar.dart';


class ListPage extends StatefulWidget {
  final String title;
  const ListPage({Key? key, this.title = "List"}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends ModularState<ListPage, ListController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // backgroundColor: themeColors.primary,
      body: CustomScrollView(
        slivers: <Widget>[
          Observer(
            builder: (_){
              return SliverAppBar(
                leading: Container(),
                flexibleSpace: LayoutBuilder(
                  builder: (context, bc) {
                    return FlexibleSpaceBar(
                      background: FlexAppbar(),
                    );
                  },
                ),
                actions: <Widget>[
                  Visibility(
                    visible: store.isDelete,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: themeColors.shoppingColor,
                      ), 
                      onPressed: () {
                        AlertDialogConfirm(
                          context: context,
                          title: 'Atenção!',
                          description: 'Deseja deletar as compras selecionadas ?',
                          onPressNot: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          onPressYes: () {
                            store.deletePasswordsSelecteds();
                            Navigator.of(context, rootNavigator: true).pop();
                          } 
                        ).show();
                      },
                    ),
                  ),
                ]
              );
            }
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SectionTitle(
                  title: 'Suas Compras',
                );
              },
              childCount: 1,
            )
          ),
          Observer(
            builder: (_) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    BoardStore item = store.webHomeController.boards[index];
                    
                    return PostItem(
                      shopping: item
                    );
                  },
                  childCount: store.webHomeController.boards.length
                ),
              );
            }
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 47.0
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, BOARD_CREATE);
        },
        child: Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }
}
