import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:commune_app/app/shared/tool/grid_delegate.dart';

import 'card_item.dart';


class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double spacing = BreakpointValue(xs: 0.0, sm: 10.0).resolve(context);

    final EdgeInsets margin = context.layout.value(
      xs: EdgeInsets.zero,
      sm: EdgeInsets.zero,
      md: EdgeInsets.fromLTRB(70, 0, 70, 0),
      lg: EdgeInsets.fromLTRB(130, 0, 130, 0),
      xl: EdgeInsets.fromLTRB(300, 0, 300, 0),
    );

    return Scrollbar(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverGutter(),
            SliverToBoxAdapter(
              child: Margin(
                child: Text('Section Title'),
              ),
            ),
            SliverGutter(),
            SliverMargin(
              margin: margin,
              sliver: SliverGrid(
                delegate: SliverChildListDelegate.fixed(
                  List.generate(
                    100,
                        (index) => CardItem(index: index),
                  ),
                ),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndMainAxisExtent(
                  crossAxisCount: 1,
                  mainAxisExtent: 60,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
