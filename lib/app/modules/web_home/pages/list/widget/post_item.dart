import 'package:commune_app/app/modules/web_home/models/board_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/web_home/pages/list/list_controller.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';

import '../../../web_home_routes.dart';

class PostItem extends StatefulWidget {

  final BoardStore? shopping;

  const PostItem({
    Key? key,
    @required this.shopping
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  ListController controller = Modular.get<ListController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.defaultPadding,
              left: SizeConfig.defaultPadding,
              right: SizeConfig.defaultPadding,
            ),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: themeColors.tertiary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: !widget!.shopping!.selected!
                    ? themeColors.tertiary
                    : themeColors.shoppingColor
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.16),
                  ),
                ],
              ),
              child: FlatButton(
                onLongPress: (){
                  controller.selectToDelete(widget!.shopping!.id!);
                  widget!.shopping!.selected = true;
                },
                onPressed: (){
                  if (!widget!.shopping!.selected!){
                    Navigator.of(context).pushNamed('$BOARD_CREATE/${widget!.shopping!.id}');
                  } else {
                    controller.removeToDelete(widget!.shopping!.id!);
                    widget!.shopping!.selected = false;
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: themeColors.shoppingColor,
                      size: 33,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10
                        ),
                        child: Text(
                            widget!.shopping!.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: themeColors.textPrimary
                          )
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ${widget!.shopping!.amount}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: themeColors.textPrimary
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}