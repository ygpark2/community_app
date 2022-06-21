import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopMenuHeader extends StatelessWidget {
  final Widget? body;

  TopMenuHeader({this.body});

  Widget _buildShortAppBar(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? Icon(CupertinoIcons.back)
                : Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'N',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.symmetric(vertical: 0),
        color: Colors.grey,
        height: 100,
        child: Center(child: Text('Expanded')),
      ),
    );
  }
}