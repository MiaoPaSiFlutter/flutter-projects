// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class _ScrollHomePageState extends State {
  ///图片地址
  String imageUrl =
      "http://file02.16sucai.com/d/file/2015/0408/779334da99e40adb587d0ba715eca102.jpg";

  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            ///顶部的标题图片部分
            buildSliverAppBar(),

            ///底部的列表部分
            buildSliverList(),
          ],
        ),
      ),
    );
  }

  ///代码清单1-2
  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.pink,
      pinned: true,
      snap: false,
      floating: true,
      leading: const Icon(Icons.home),
      actions: const <Widget>[Icon(Icons.menu)],
      title: const Text("这里是标题"),
      expandedHeight: 180,
      flexibleSpace: FlexibleSpaceBar(
        background: Row(
          children: <Widget>[
            Expanded(
              child: Image.network(imageUrl, fit: BoxFit.cover),
            )
          ],
        ),
      ),
    );
  }

  ///代码清单1-3
  SliverList buildSliverList() {
    return SliverList(
      ///懒加载代理
      delegate: SliverChildBuilderDelegate((BuildContext context, num index) {
        ///子Item的布局
        return Container(
          height: 44,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("item- $index"),
        );
      }, childCount: 100), //子Item的个数
    );
  }
}
