import 'package:flutter/material.dart';
import 'package:commune_app/app/modules/chat/models/user/data_user.dart';
import 'package:commune_app/app/shared/widgets/button_widget.dart';
import 'package:commune_app/app/shared/widgets/text_widget.dart';


class ItemUser extends StatelessWidget {
  final DataUser item;
  const ItemUser(this.item, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.topRight,
      child: ButtonWidget(
        onPress: () {},
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextWidget(item!.message, color: Theme.of(context).textSelectionHandleColor,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
