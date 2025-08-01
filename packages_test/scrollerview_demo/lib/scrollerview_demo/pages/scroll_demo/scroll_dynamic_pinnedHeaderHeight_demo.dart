// ignore_for_file: unnecessary_cast

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import 'package:loading_more_list/loading_more_list.dart';

class ScrollDynamicPinnedHeaderHeightDemo extends StatefulWidget {
  const ScrollDynamicPinnedHeaderHeightDemo({super.key});

  @override
  _ScrollDynamicPinnedHeaderHeightDemoState createState() =>
      _ScrollDynamicPinnedHeaderHeightDemoState();
}

class _ScrollDynamicPinnedHeaderHeightDemoState
    extends State<ScrollDynamicPinnedHeaderHeightDemo>
    with TickerProviderStateMixin {
  late final TabController primaryTC;
  final ScrollController sc = ScrollController();

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    primaryTC.dispose();
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.update),
        onPressed: () {
          //change pinnedHeaderHeight here
          final double before = pinnedHeaderHeight;
          pinnedHeaderHeight += 100.0;
          sc.position.applyContentDimensions(sc.position.minScrollExtent,
              sc.position.maxScrollExtent + before);
        },
      ),
    );
  }

  late double pinnedHeaderHeight;
  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return ExtendedNestedScrollView(
      controller: sc,
      headerSliverBuilder: (BuildContext c, bool f) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            title: const Text('pinned header height'),
            flexibleSpace: FlexibleSpaceBar(
              //centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: Image.asset(
                NormalModuleUtils.configPackagesImage(
                    packagename: 'scrollerview_demo',
                    name: 'assets/467141054.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          )
        ];
      },
      //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      body: Column(
        children: <Widget>[
          TabBar(
            controller: primaryTC,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            isScrollable: false,
            unselectedLabelColor: Colors.grey,
            tabs: const <Tab>[
              Tab(text: 'Tab0'),
              Tab(text: 'Tab1'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: <Widget>[
                GlowNotificationWidget(
                  ListView.builder(
                    //store Page state
                    key: const PageStorageKey<String>('Tab0'),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: Text('${const Key('Tab0')}: ListView$i'),
                      );
                    },
                    itemCount: 50,
                  ),
                  showGlowLeading: false,
                ),
                GlowNotificationWidget(
                  ListView.builder(
                    //store Page state
                    key: const PageStorageKey<String>('Tab1'),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: Text('${const Key('Tab1')}: ListView$i'),
                      );
                    },
                    itemCount: 50,
                  ),
                  showGlowLeading: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
