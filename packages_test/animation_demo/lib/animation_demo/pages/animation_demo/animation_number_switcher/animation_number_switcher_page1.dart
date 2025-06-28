import 'dart:async';
import 'package:flutter/material.dart';

class AnimationNumberSwitcherPage1 extends StatefulWidget {
  const AnimationNumberSwitcherPage1({super.key});

  @override
  State createState() => _AnimationNumberSwitcherPage1State();
}

class _AnimationNumberSwitcherPage1State extends State
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("AnimatedSwitcher 动画 "),
      ),
      //线性排列
      body: Column(
        children: [
          //第一部分 效果区域
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: buildAnimatedSwitcher(context),
          ),
          //第二部分 按钮区域 与代码清单 代码清单 6-29 中的一致
          buildContainer()
        ],
      ),
    );
  }

  int _count = 200;

  int _flag = 1;

  Widget buildAnimatedSwitcher(BuildContext context) {
    return AnimatedSwitcher(
      //切换时间 定义
      duration: const Duration(milliseconds: 1300),
      //让文本动起来
      transitionBuilder: (Widget child, Animation<double> animation) {
        _flag++;

        Offset startOffset = const Offset(0.0, -1.0);
        Offset endOffset = const Offset(0.0, 0.0);

        if (_flag % 2 == 0) {
          startOffset = const Offset(0.0, 1.0);
          endOffset = const Offset(0.0, 0.0);
        }

        //再来个平移动画
        return SlideTransition(
          //先来个透明渐变动画
          position: Tween(begin: startOffset, end: endOffset).animate(
            CurvedAnimation(curve: Curves.linear, parent: animation),
          ),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(curve: Curves.linear, parent: animation),
            ),
            //再来个缩放动画
            child: ScaleTransition(
              scale: Tween(begin: 0.6, end: 1.0).animate(
                  CurvedAnimation(curve: Curves.linear, parent: animation)),
              child: child,
            ),
          ),
        );
      },
      //定义 文本
      child: Text(
        "$_count",
        key: ValueKey("$_count"),
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 44),
      ),
    );
  }

  //定义定时器
  Timer? _timer;

  void startTimer() {
    stopTimer();

    //间隔 1300 毫秒执行一次
    _timer = Timer.periodic(const Duration(milliseconds: 1600), (timer) {
      print("执行");
      setState(() {
        _count++;
      });
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  Container buildContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        //子Widget居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("开始"),
            onPressed: () {
              startTimer();
            },
          ),
          const SizedBox(width: 22),
          ElevatedButton(
            child: const Text("停止"),
            onPressed: () {
              stopTimer();
            },
          ),
        ],
      ),
    );
  }
}
