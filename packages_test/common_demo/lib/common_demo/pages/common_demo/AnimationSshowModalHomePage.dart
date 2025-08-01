import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/1.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

class AnimationSshowModalHomePage extends StatefulWidget {
  const AnimationSshowModalHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<AnimationSshowModalHomePage> {
  String resultMessage = "--";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("浏览图片"),
      ),
      //线性布局
      //子Widget 竖直方向排开
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                showBottomSheet();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    NormalModuleUtils.configPackagesImage(
                      packagename: 'common_demo',
                      name: "assets/banner3.webp",
                    ),
                    width: 76,
                    fit: BoxFit.fill,
                    height: 76,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "每日分享 精彩一刻",
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          child: const Text(
                            "优美的应用体验 来自于细节的处理，更源自于码农的自我要求与努力",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          //一个按钮
        ],
      ),
    );
  }

  //显示底部弹框的功能
  void showBottomSheet() {
    showModal(
      context: context,
      //动画过渡配置
      configuration: const FadeScaleTransitionConfiguration(
        //阴影背景颜色
        barrierColor: Colors.black54,
        //打开新的Widget 的时间
        transitionDuration: Duration(milliseconds: 200),
        //关闭新的Widget 的时间
        reverseTransitionDuration: Duration(milliseconds: 200),
      ),
      builder: (BuildContext context) {
        //显示的Widget
        return HomePage2();
      },
    );
  }
}

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //背景透明
      backgroundColor: Colors.transparent,
      body: Theme(
        data: ThemeData(
          //去除点击事件的水波纹效果
          splashColor: Colors.transparent,
          //云除点击事件的高亮效果
          highlightColor: Colors.transparent,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Center(
              child: Image.asset(NormalModuleUtils.configPackagesImage(
                packagename: 'common_demo',
                name: "assets/banner3.webp",
              )),
            ),
          ),
        ),
      ),
    );
  }
}
