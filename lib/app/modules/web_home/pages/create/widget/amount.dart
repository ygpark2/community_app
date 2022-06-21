import 'package:commune_app/app/modules/web_home/pages/create/create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';
import 'package:commune_app/app/shared/widgets/input_text.dart';

class Amount extends StatefulWidget {
  const Amount({
    Key? key,
  }) : super(key: key);

  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends State<Amount> {

  CreateController controller = Modular.get<CreateController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          // overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                bottom: 17
              ),
              child: Column(
                children: [
                  Observer(
                    builder: (_){
                      return Text(
                        'R\$ ${controller.amount}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getPropScreenWidth(50),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  ),
                  Container(
                    width: getPropScreenWidth(275),
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(400, 20)
                      ),
                      color: themeColors.shoppingColor.withOpacity(0.2)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8
                    ),
                    child: Observer(
                      builder: (_){
                        return Column(
                          children: [
                            Text(
                              "Quantidade de itens: ${controller.qtItems}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: themeColors.textPrimary,
                              ),
                            ),
                            Visibility(
                              visible: controller.erroItems,
                              child: Text(
                                controller.msgErroItems,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red[600]
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Observer(
          builder: (_){
            return InputText(
              placeholder: 'Titulo da compra',
              change: (value){
                controller.newBoard.title = value;
              },
              msgError: 'Titulo não pode ser branco ou vazio.',
              value: controller.newBoard.title ?? "",
              error: controller.erroTitle,
              label: 'label text',
            );
          }
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultPadding,
            vertical: SizeConfig.defaultPadding/2,
          ),
          child: Row(
            children: [
              Container(
                width: getPropScreenWidth(70),
                child: Text(
                  "Quant.",
                  style: TextStyle(
                    fontSize: 14,
                    color: themeColors.textSecondary,
                  )
                ),
              ),
              Expanded(
                child: Text(
                  "Nome",
                  style: TextStyle(
                    fontSize: 14,
                    color: themeColors.textSecondary,
                  )
                ),
              ),
              Container(
                width: getPropScreenWidth(95),
                child: Text(
                  "Valor",
                  style: TextStyle(
                    fontSize: 14,
                    color: themeColors.textSecondary,
                  )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
