
import 'package:flutter/material.dart';
import 'package:commune_app/app/shared/models/category/data_category.dart';
import 'package:commune_app/app/shared/widgets/post_card_widget.dart';
import 'package:commune_app/app/shared/tool/utils.dart';


class ItemPost extends StatefulWidget {
  final Map<String, List>? postData;

  const ItemPost({Key? key, this.postData}) : super(key: key);

  @override
  _ItemPostState createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  int currentIndex = 0;
  Map<String, List> _newsData = Map<String, List>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    setState(() {
      _newsData = Map.from(widget!.postData!);
    });
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Top News Updates",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Times",
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 25),
              alignment: Alignment.centerLeft,
              child: TabBar(
                  labelPadding: EdgeInsets.only(right: 15),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                      fontFamily: "Avenir",
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black45,
                  unselectedLabelStyle: TextStyle(
                      fontFamily: "Avenir",
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  tabs: List.generate(categories.length,
                          (index) => Text(categories[index].name))),
            ),
          ),
        ];
      },
      body: Container(
        child: TabBarView(
            controller: _tabController,
            children: List.generate(
              categories.length,
                  (index) {
                var key = categories[index]
                    .imageUrl
                    .toString()
                    .split("/")[3]
                    .split(".")[0]
                    .replaceAll("_", "-");
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  itemBuilder: (context, i) {
                    String time = _newsData[key]![i]['pubDate']['__cdata'];
                    DateTime timeIST = DateTime.parse(time);
                    timeIST = timeIST
                        .add(Duration(hours: 5))
                        .add(Duration(minutes: 30));
                    return PostCardWidget(
                      title: _newsData[key]![i]['title']['__cdata'].replaceAll(r"\'",''),
                      subtitle: _newsData[key]![i]['description']['__cdata'],
                      time: timeIST.day.toString() +
                          " " +
                          Utils.getMonthNumberInWords(month: timeIST.month) +
                          " " +
                          timeIST.toString().split(" ")[1].substring(0, 5),
                      imageUrl: _newsData[key]![i]['media\$content']['url'],
                    );
                  },
                  itemCount: _newsData[key]?.length ?? 0,
                );
              },
            )),
      ),
    );
  }
}