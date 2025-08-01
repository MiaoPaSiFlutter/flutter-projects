part of persistent_bottom_nav_bar;

///Navigation bar controller for `PersistentTabView`.
class PersistentTabController extends ChangeNotifier {
  PersistentTabController({final int initialIndex = 0})
      : _index = initialIndex,
        assert(initialIndex >= 0, "Value cannot be less than zero");

  bool _isDisposed = false;
  int get index => _index;
  int _index;

  set index(final int value) {
    assert(value >= 0, "Value cannot be less than zero");
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  void jumpToTab(final int value) {
    assert(value >= 0, "Value cannot be less than zero");
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class PersistentTabScaffold extends StatefulWidget {
  PersistentTabScaffold({
    required this.tabBar,
    required this.tabBuilder,
    final Key? key,
    this.controller,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.bottomScreenMargin,
    this.stateManagement,
    this.screenTransitionAnimation,
    this.hideNavigationBarWhenKeyboardShows,
    this.itemCount,
    this.animatePadding = false,
  })  : assert(
            controller == null || controller.index < itemCount!,
            "The PersistentTabController's current index ${controller.index} is "
            "out of bounds for the tab bar with ${tabBar.navBarEssentials!.items!.length} tabs"),
        super(key: key);

  final PersistentBottomNavBar tabBar;

  final PersistentTabController? controller;

  final IndexedWidgetBuilder tabBuilder;

  final Color? backgroundColor;

  final bool resizeToAvoidBottomInset;

  final int? itemCount;

  final double? bottomScreenMargin;

  final bool? stateManagement;

  final ScreenTransitionAnimation? screenTransitionAnimation;

  final bool? hideNavigationBarWhenKeyboardShows;

  final bool animatePadding;

  @override
  _PersistentTabScaffoldState createState() => _PersistentTabScaffoldState();
}

class _PersistentTabScaffoldState extends State<PersistentTabScaffold> {
  PersistentTabController? _controller;
  int? _selectedIndex;
  late bool _isTapAction;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.controller!.index;
    _isTapAction = false;
    _updateTabController();
  }

  void _updateTabController({final bool shouldDisposeOldController = false}) {
    final PersistentTabController newController = widget.controller ??
        PersistentTabController(
            initialIndex: widget.tabBar.navBarEssentials!.selectedIndex!);

    if (newController == _controller) {
      return;
    }

    if (shouldDisposeOldController) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller!.removeListener(_onCurrentIndexChange);
    }

    newController.addListener(_onCurrentIndexChange);
    _controller = newController;
  }

  void _onCurrentIndexChange() {
    assert(
        _controller!.index >= 0 && _controller!.index < widget.itemCount!,
        "The $runtimeType's current index ${_controller!.index} is "
        "out of bounds for the tab bar with ${widget.itemCount} tabs");
    setState(() {});
  }

  @override
  void didUpdateWidget(final PersistentTabScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController(
          shouldDisposeOldController: oldWidget.controller == null);
    } else if (_controller!.index >= widget.itemCount!) {
      _controller!.index = widget.itemCount! - 1;
    }
  }

  @override
  Widget build(final BuildContext context) {
    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);
    if (_isTapAction) {
      _isTapAction = false;
    } else {
      _selectedIndex = widget.tabBar.navBarEssentials!.selectedIndex;
    }
    Widget content = _TabSwitchingView(
      currentTabIndex: _controller!.index,
      tabCount: widget.itemCount,
      tabBuilder: widget.tabBuilder,
      stateManagement: widget.stateManagement,
      screenTransitionAnimation: widget.screenTransitionAnimation,
      backgroundColor: Colors.transparent,
    );
    double contentPadding = 0;

    if (widget.resizeToAvoidBottomInset) {
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
    }

    if (!widget.tabBar.opaque(_selectedIndex)) {
      contentPadding = 0.0;
    } else if (widget
            .tabBar.navBarDecoration!.adjustScreenBottomPaddingOnCurve &&
        widget.tabBar.navBarDecoration!.borderRadius != BorderRadius.zero) {
      final double bottomPadding = widget.bottomScreenMargin ??
          widget.tabBar.navBarEssentials!.navBarHeight! -
              (widget.tabBar.navBarDecoration!.borderRadius != null
                  ? min(
                      widget.tabBar.navBarEssentials!.navBarHeight! as num,
                      max(
                              widget.tabBar.navBarDecoration!.borderRadius!
                                  .topRight.y,
                              widget.tabBar.navBarDecoration!.borderRadius!
                                  .topLeft.y) +
                          (widget.tabBar.navBarDecoration?.border != null
                              ? widget.tabBar.navBarDecoration!.border!
                                  .dimensions.vertical
                              : 0.0))
                  : 0.0);
      contentPadding = bottomPadding;
    } else {
      if (!widget.resizeToAvoidBottomInset ||
          widget.tabBar.navBarEssentials!.navBarHeight! >
              existingMediaQuery.viewInsets.bottom) {
        final double bottomPadding = widget.bottomScreenMargin ??
            widget.tabBar.navBarEssentials!.navBarHeight! +
                (widget.tabBar.navBarDecoration?.border != null
                    ? widget
                        .tabBar.navBarDecoration!.border!.dimensions.vertical
                    : 0.0);
        contentPadding = bottomPadding;
      }
    }

    if (widget.tabBar.hideNavigationBar != null) {
      content = MediaQuery(
        data: newMediaQuery,
        child: AnimatedContainer(
          duration: Duration(
              milliseconds:
                  widget.animatePadding || widget.tabBar.hideNavigationBar!
                      ? widget.tabBar.hideNavigationBar!
                          ? 200
                          : 400
                      : 0),
          curve:
              widget.tabBar.hideNavigationBar! ? Curves.linear : Curves.easeIn,
          padding: EdgeInsets.only(bottom: contentPadding),
          child: content,
        ),
      );
    } else {
      content = MediaQuery(
        data: newMediaQuery,
        child: Container(
          // color: widget.tabBar.navBarDecoration!.colorBehindNavBar,
          padding: EdgeInsets.only(bottom: contentPadding),
          child: content,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        content,
        MediaQuery(
          data: existingMediaQuery.copyWith(textScaleFactor: 1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: widget.tabBar.copyWith(
              selectedIndex: _controller!.index,
              onItemSelected: (final newIndex) {
                _controller!.index = newIndex;
                if (widget.tabBar.navBarEssentials!.onItemSelected != null) {
                  setState(() {
                    _selectedIndex = newIndex;
                    _isTapAction = true;
                    widget.tabBar.navBarEssentials!.onItemSelected!(newIndex);
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller!.removeListener(_onCurrentIndexChange);
    }

    super.dispose();
  }
}

class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({
    required this.currentTabIndex,
    required this.tabCount,
    required this.stateManagement,
    required this.tabBuilder,
    required this.screenTransitionAnimation,
    required this.backgroundColor,
  }) : assert(tabCount != null && tabCount > 0,
            "tabCount must not be null and less than 1");

  final int currentTabIndex;
  final int? tabCount;
  final IndexedWidgetBuilder tabBuilder;
  final bool? stateManagement;
  final ScreenTransitionAnimation? screenTransitionAnimation;
  final Color? backgroundColor;

  @override
  _TabSwitchingViewState createState() => _TabSwitchingViewState();
}

class _TabSwitchingViewState extends State<_TabSwitchingView>
    with TickerProviderStateMixin {
  final List<bool> shouldBuildTab = <bool>[];
  final List<FocusScopeNode> tabFocusNodes = <FocusScopeNode>[];
  final List<FocusScopeNode> discardedNodes = <FocusScopeNode>[];
  late List<AnimationController?> _animationControllers;
  late List<Animation<double>?> _animations;
  int? _tabCount;
  int? _lastIndex;
  bool _animationCompletionIndex = false;
  bool? _showAnimation;
  double? _animationValue;
  Curve? _animationCurve;
  Key? key;

  @override
  void initState() {
    super.initState();
    shouldBuildTab.addAll(List<bool>.filled(widget.tabCount!, false));
    _lastIndex = widget.currentTabIndex;
    _tabCount = widget.tabCount;
    _animationCompletionIndex = false;
    _showAnimation = widget.screenTransitionAnimation!.animateTabTransition;

    if (!widget.stateManagement!) {
      key = UniqueKey();
    }

    _initAnimationControllers();
  }

  void _initAnimationControllers() {
    if (widget.screenTransitionAnimation!.animateTabTransition) {
      _animationControllers =
          List<AnimationController?>.filled(widget.tabCount!, null);
      _animations = List<Animation<double>?>.filled(widget.tabCount!, null);
      _animationCurve = widget.screenTransitionAnimation!.curve;
      for (int i = 0; i < widget.tabCount!; ++i) {
        _animationControllers[i] = AnimationController(
            vsync: this, duration: widget.screenTransitionAnimation!.duration);
        _animations[i] = Tween(begin: 0.toDouble(), end: 0.toDouble())
            .chain(CurveTween(curve: widget.screenTransitionAnimation!.curve))
            .animate(_animationControllers[i]!);
      }

      for (int i = 0; i < widget.tabCount!; ++i) {
        _animationControllers[i]!.addListener(() {
          if (_animationControllers[i]!.isCompleted &&
              _animationCompletionIndex) {
            setState(() {
              if (!widget.stateManagement!) {
                key = UniqueKey();
              }
              _lastIndex = widget.currentTabIndex;
            });
            _animationCompletionIndex = false;
          }
        });
      }
    }
  }

  void _focusActiveTab() {
    if (widget.screenTransitionAnimation!.animateTabTransition) {
      _newPageAnimation();
    }
    if (tabFocusNodes.length != widget.tabCount) {
      if (tabFocusNodes.length > widget.tabCount!) {
        discardedNodes.addAll(tabFocusNodes.sublist(widget.tabCount!));
        tabFocusNodes.removeRange(widget.tabCount!, tabFocusNodes.length);
      } else {
        tabFocusNodes.addAll(
          List<FocusScopeNode>.generate(
            widget.tabCount! - tabFocusNodes.length,
            (final index) => FocusScopeNode(
                debugLabel:
                    "$CupertinoTabScaffold Tab ${index + tabFocusNodes.length}"),
          ),
        );
      }
    }
    FocusScope.of(context).setFirstFocus(tabFocusNodes[widget.currentTabIndex]);
    if (widget.screenTransitionAnimation!.animateTabTransition) {
      _lastPageAnimation();
    }
  }

  void _lastPageAnimation() {
    if (_lastIndex! > widget.currentTabIndex &&
        !_animationControllers[_lastIndex!]!.isAnimating) {
      _animationControllers[_lastIndex!]!.reset();
      _animations[_lastIndex!] =
          Tween(begin: 0.toDouble(), end: _animationValue)
              .chain(CurveTween(curve: widget.screenTransitionAnimation!.curve))
              .animate(_animationControllers[_lastIndex!]!);
      _animationControllers[_lastIndex!]!.forward();
    } else if (_lastIndex! < widget.currentTabIndex &&
        !_animationControllers[_lastIndex!]!.isAnimating) {
      _animationControllers[_lastIndex!]!.reset();
      _animations[_lastIndex!] =
          Tween(begin: 0.toDouble(), end: -_animationValue!)
              .chain(CurveTween(curve: widget.screenTransitionAnimation!.curve))
              .animate(_animationControllers[_lastIndex!]!);
      _animationControllers[_lastIndex!]!.forward();
    }
  }

  void _newPageAnimation() {
    if (_lastIndex! > widget.currentTabIndex &&
        !_animationControllers[widget.currentTabIndex]!.isAnimating) {
      _animationControllers[widget.currentTabIndex]!.reset();
      _animations[widget.currentTabIndex] =
          Tween(begin: -_animationValue!, end: 0.toDouble())
              .chain(CurveTween(curve: widget.screenTransitionAnimation!.curve))
              .animate(_animationControllers[widget.currentTabIndex]!);
      _animationControllers[widget.currentTabIndex]!.forward();
      _animationCompletionIndex = true;
    } else if (_lastIndex! < widget.currentTabIndex &&
        !_animationControllers[widget.currentTabIndex]!.isAnimating) {
      _animationControllers[widget.currentTabIndex]!.reset();
      _animations[widget.currentTabIndex] =
          Tween(begin: _animationValue, end: 0.toDouble())
              .chain(CurveTween(curve: widget.screenTransitionAnimation!.curve))
              .animate(_animationControllers[widget.currentTabIndex]!);
      _animationControllers[widget.currentTabIndex]!.forward();
      _animationCompletionIndex = true;
    }
  }

  Stack _buildScreens() => Stack(
        fit: StackFit.expand,
        children: List<Widget>.generate(widget.tabCount!, (final index) {
          final bool active = index == widget.currentTabIndex ||
              (widget.screenTransitionAnimation!.animateTabTransition &&
                  index == _lastIndex);
          shouldBuildTab[index] = active || shouldBuildTab[index];

          return Offstage(
            offstage: !active,
            child: TickerMode(
              enabled: active,
              child: FocusScope(
                node: tabFocusNodes[index],
                child: Builder(
                    builder: (final context) => shouldBuildTab[index]
                        ? (widget
                                .screenTransitionAnimation!.animateTabTransition
                            ? AnimatedBuilder(
                                animation: _animations[index]!,
                                builder: (final context, final child) =>
                                    Transform.translate(
                                  offset: Offset(_animations[index]!.value, 0),
                                  child: widget.tabBuilder(context, index),
                                ),
                              )
                            : widget.tabBuilder(context, index))
                        : Container()),
              ),
            ),
          );
        }),
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(final _TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final int lengthDiff = widget.tabCount! - shouldBuildTab.length;
    if (lengthDiff > 0) {
      shouldBuildTab.addAll(List<bool>.filled(lengthDiff, false));
    } else if (lengthDiff < 0) {
      shouldBuildTab.removeRange(widget.tabCount!, shouldBuildTab.length);
    }
    _focusActiveTab();
  }

  @override
  void dispose() {
    for (final FocusScopeNode focusScopeNode in tabFocusNodes) {
      focusScopeNode.dispose();
    }
    for (final FocusScopeNode focusScopeNode in discardedNodes) {
      focusScopeNode.dispose();
    }
    if (widget.screenTransitionAnimation!.animateTabTransition) {
      for (final AnimationController? controller in _animationControllers) {
        controller!.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    _animationValue = MediaQuery.of(context).size.width;
    if (_tabCount != widget.tabCount) {
      _tabCount = widget.tabCount;
      _initAnimationControllers();
    }
    if (widget.screenTransitionAnimation!.animateTabTransition &&
            _animationControllers.first!.duration !=
                widget.screenTransitionAnimation!.duration ||
        _animationCurve != widget.screenTransitionAnimation!.curve) {
      _initAnimationControllers();
    }
    if (_showAnimation !=
        widget.screenTransitionAnimation!.animateTabTransition) {
      _showAnimation = widget.screenTransitionAnimation!.animateTabTransition;
      key = UniqueKey();
    }
    return Container(
      child: widget.stateManagement!
          ? _buildScreens()
          : KeyedSubtree(
              key: key,
              child: _buildScreens(),
            ),
    );
  }
}
