import 'package:commune_app/app/modules/web_home/models/board_item_store.dart';
import 'package:commune_app/app/modules/web_home/pages/create/create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';

class ShoppingItem extends StatefulWidget {

  final BoardItemStore item;

  const ShoppingItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ShoppingItemState createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {

  CreateController controller = Modular.get<CreateController>();

  // MaskedTextController controllerQt;
  late TextEditingController controllerName;
  // MoneyMaskedTextController controllerValue;

  @override
  void initState() {
    super.initState();

    /*
    controllerQt = new MaskedTextController(
      mask: '000',
    );
     */

    controllerName = TextEditingController();

    /*
    controllerValue = new MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: ',',
      precision: 2,
      leftSymbol: 'R\$ ',
    );
     */

    // controllerQt.text = widget.item.qt;
    controllerName.text = widget.item.name!;
    // controllerValue.text = widget.item.value;
  }

  @override
  void dispose() {
    super.dispose();

    /*
    if (controllerQt.dispose != null){
      controllerQt.dispose();
    }
     */

    if (controllerName.dispose != null){
      controllerName.dispose();
    }

    /*
    if (controllerValue.dispose != null){
      controllerValue.dispose();
    }
     */
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.defaultPadding,
        right: SizeConfig.defaultPadding,
        bottom: SizeConfig.defaultPadding
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: SizeConfig.defaultPadding / 2
            ),
            child: Container(
              width: getPropScreenWidth(70) - SizeConfig.defaultPadding,
              height: 45,
              decoration: BoxDecoration(
                color: themeColors.tertiary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.item.error!.split(':').contains('qt')
                    ? Colors.red[600]!
                    : themeColors.textSecondary,
                  width: 0.5
                ),
              ),
              child: TextFormField(
                // controller: controllerQt,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp("^([1-9][0-9]{0,2}|999)\$")
                    ) //Only Text as input
                ],
                onChanged: (value){
                  if (value.length < 4) {
                    if (value.isEmpty) {
                      widget.item.qt = '0';
                    } else {
                      widget.item.qt = (int.parse(value) == 0) ? '0' : value;
                    }

                    controller.setAmount();
                  }
                },
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'Qt',
                  hintStyle: TextStyle(
                    color: themeColors.textSecondary,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    right: 9,
                    bottom: 5
                  ),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: themeColors.textPrimary
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: SizeConfig.defaultPadding / 2
              ),
              child: Observer(
                builder: (_){
                  return Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: themeColors.tertiary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: widget.item.error!.split(':').contains('name')
                          ? Colors.red[600]!
                          : themeColors.textSecondary,
                        width: 0.5
                      ),
                    ),
                    child: TextField(
                      controller: controllerName,
                      onChanged: (value){
                        widget.item.name = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nome do produto',
                        hintStyle: TextStyle(
                          color: themeColors.textSecondary,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                          bottom: 5
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: themeColors.textPrimary
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
          Container(
            width: getPropScreenWidth(95),
            height: 45,
            decoration: BoxDecoration(
              color: themeColors.tertiary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: themeColors.textSecondary,
                width: 0.5
              ),
            ),
            child: TextField(
              // controller: controllerValue,
              onChanged: (value) {
                /*
                String newValue = controller.getTwoPrecision(
                  controllerValue.numberValue.toString()
                );
                 */
                // widget.item.setValue(newValue);
                controller.setAmount();
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'valor',
                hintStyle: TextStyle(
                  color: themeColors.textSecondary,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5
                ),
              ),
              style: TextStyle(
                fontSize: 14,
                color: themeColors.textPrimary
              ),
            ),
          ),
        ],
      )
    );
  }
}