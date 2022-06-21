import 'package:commune_app/app/modules/board/models/board_item_store.dart';
import 'package:commune_app/app/modules/board/models/board_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';

import 'widget/amount.dart';
import 'widget/Board_item.dart';
import 'create_controller.dart';

class CreatePage extends StatefulWidget {
  final int? id;
  const CreatePage({Key? key, this.id }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends ModularState<CreatePage, CreateController> {
  //use 'controller' variable to access controller

  late ReactionDisposer whenDispose;

  @override
  void initState() {
    super.initState();
    store.setNewBoard(
      new BoardStore(
        id: 20, 
        title: null,
        amount: 0.0,
        qtItems: 0,
        selected: false,
        items: []
      )
    );

    if (widget.id != null) {
      store.prepareBoardToEdit(store.boardController.getBoard(widget.id!));
    } else {
      whenDispose = when(
        (r) => store.idNewBoard != null, 
        () => store.newBoard.id = store.idNewBoard
      );
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    if (whenDispose != null) {
      whenDispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: themeColors.primary,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor:  themeColors.secondary,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: themeColors.shoppingColor,
                ), 
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.save,
                    color: themeColors.shoppingColor,
                  ), 
                  onPressed: () {
                    if (store.boardIsValid()) {
                      String message = 'Compra salva com sucesso.';

                      if (widget.id == null) {
                        store.createBoard(store.newBoard);
                      } else {
                        store.updateBoard(store.newBoard);
                        message = 'Compra atualizada com sucesso.';
                      }

                      // SnackMesage(context).show('$message');
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Amount();
                },
                childCount: 1,
              ),
            ),
            Observer(
              builder: (_){

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      BoardItemStore item = store.newBoard.items[index];

                      return Dismissible(
                        key: Key(item.id.toString()),
                        onDismissed: (direction) {
                          store.newBoard.items.remove(item);
                          store.setAmount();
                        },
                        child: ShoppingItem(
                          item: item,
                        ),
                      );
                    },
                    childCount: store.newBoard.items.length,
                  ),
                );
              }
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 40.0
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            store.addItem();
          },
          child: Icon(
            Icons.add,
            size: 28,
            color: themeColors.primary,
          ),
          backgroundColor: themeColors.shoppingColor,
        ),
      ),
    );
  }
}

