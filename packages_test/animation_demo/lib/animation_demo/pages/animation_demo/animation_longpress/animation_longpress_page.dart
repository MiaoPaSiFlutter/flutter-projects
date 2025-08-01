import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AnimationLongpressPage extends StatefulWidget {
  const AnimationLongpressPage({super.key});

  @override
  State createState() => _AnimationLongpressPageState();
}

class _AnimationLongpressPageState extends State<AnimationLongpressPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  final GlobalKey<CoachMarkState> _calendarMark = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: const Text("Hello"),
        actions: <Widget>[
          CoachMark(
            key: _calendarMark,
            id: 'calendar_mark',
            text: 'Tap here to use the Calendar!',
            child: GestureDetector(
              onLongPress: () => _calendarMark.currentState!.show(),
              child: IconButton(
                onPressed: () => print('calendar'),
                icon: const Icon(Icons.calendar_today),
              ),
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'reset',
                  child: Text('Reset'),
                ),
              ];
            },
            onSelected: (String value) {
              if (value == 'reset') {
                _calendarMark.currentState!.reset();
                ScaffoldMessenger.of(_scaffold.currentContext!)
                    .showSnackBar(const SnackBar(
                  content:
                      Text('Hot-restart the app to see the coach-mark again.'),
                ));
              }
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}

class CoachMark extends StatefulWidget {
  const CoachMark({
    Key? key,
    required this.id,
    required this.text,
    required this.child,
  }) : super(key: key);

  final String id;
  final String text;
  final Widget child;

  @override
  CoachMarkState createState() => CoachMarkState();
}

typedef CoachMarkRect = Rect Function();

class CoachMarkState extends State<CoachMark> {
  _CoachMarkRoute? _route;

  @override
  void initState() {
    super.initState();
    test().then((bool seen) {
      if (seen == false) {
        show();
      }
    });
  }

  @override
  void didUpdateWidget(CoachMark oldWidget) {
    super.didUpdateWidget(oldWidget);
    _rebuild();
  }

  @override
  void reassemble() {
    super.reassemble();
    _rebuild();
  }

  @override
  void dispose() {
    dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rebuild();
    return widget.child;
  }

  void show() {
    if (_route == null) {
      _route = _CoachMarkRoute(
        rect: () {
          final box = context.findRenderObject() as RenderBox;
          return box.localToGlobal(Offset.zero) & box.size;
        },
        text: widget.text,
        padding: const EdgeInsets.all(4.0),
        onPop: () {
          _route = null;
          mark();
        },
      );
      Navigator.of(context).push(_route!);
    }
  }

  void _rebuild() {
    if (_route != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _route?.changedExternalState();
      });
    }
  }

  void dismiss() {
    if (_route != null) {
      _route?.dispose();
      _route = null;
    }
  }

  Future<bool> test() async {
    return Future.value(true);
  }

  void mark() async {}

  void reset() async {}
}

class _CoachMarkRoute<T> extends PageRoute<T> {
  _CoachMarkRoute({
    required this.rect,
    required this.text,
    this.padding,
    this.onPop,
    this.shadow = const BoxShadow(color: Color(0xB2212121), blurRadius: 8.0),
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 450),
    RouteSettings? settings,
  }) : super(settings: settings);

  final CoachMarkRect rect;
  final String text;
  final EdgeInsets? padding;
  final BoxShadow shadow;
  final VoidCallback? onPop;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  bool didPop(T? result) {
    if (onPop != null) onPop!();
    return super.didPop(result);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Rect position = rect();
    if (padding != null) {
      position = padding!.inflateRect(position);
    }
    position = Rect.fromCircle(
        center: position.center, radius: position.longestSide * 0.5);
    final clipper = _CoachMarkClipper(position);
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => Navigator.of(context).pop(),
        child: IgnorePointer(
          child: FadeTransition(
            opacity: animation,
            child: Stack(
              children: <Widget>[
                //背景模糊
                ClipPath(
                  clipper: clipper,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                //
                CustomPaint(
                  painter: _CoachMarkPainter(
                    rect: position,
                  ),
                  child: SizedBox.expand(
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;
}

class _CoachMarkClipper extends CustomClipper<Path> {
  final Rect rect;

  _CoachMarkClipper(this.rect);

  @override
  Path getClip(Size size) {
    return Path.combine(PathOperation.difference,
        Path()..addRect(Offset.zero & size), Path()..addOval(rect));
  }

  @override
  bool shouldReclip(_CoachMarkClipper old) => rect != old.rect;
}

class _CoachMarkPainter extends CustomPainter {
  _CoachMarkPainter({
    required this.rect,
  });

  final Rect rect;
  final BoxShadow shadow =
      const BoxShadow(color: Color(0xB2212121), blurRadius: 8.0);

  @override
  void paint(Canvas canvas, Size size) {
    final circle = rect.inflate(shadow.spreadRadius);
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawColor(shadow.color, BlendMode.dstATop);
    canvas.drawCircle(circle.center, circle.longestSide * 0.5,
        shadow.toPaint()..blendMode = BlendMode.clear);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CoachMarkPainter old) => old.rect != rect;

  @override
  bool shouldRebuildSemantics(_CoachMarkPainter oldDelegate) => false;
}
