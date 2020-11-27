library animated_fab;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedFAB extends StatefulWidget {
  AnimatedFAB({
    Key? key,
    required this.scrollController,
    this.maxWidth = 90,
    this.contentPaddingFactor = 0.1,
    required this.icon,
    required this.text,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 15,
    ),
    required this.onTap,
    this.backgroundColor,
    this.backgroundGradient,
    this.elevation = 6.0,
  })  : assert(!(backgroundColor == null && backgroundGradient == null),
            "Color and Gradient both can't be null"),
        assert(!(backgroundColor != null && backgroundGradient != null),
            "Color and Gradient both can't be defined"),
        super(key: key);

  /// The [ScrollController] which is used by the FAB to get notified when the
  /// user starts scrolling.
  final ScrollController scrollController;

  /// Called when the user presses on the FAB.
  final Function() onTap;

  /// Maximum width of the FAB. This is the width the FAB animates to when user
  /// starts scrolling. Needs to be adjusted for different lengths of [text].
  /// Default: 90
  final double maxWidth;

  /// Factor controlling how much padding is apllied to the contents of the FAB
  /// when it is expanded.
  /// Default: 0.1
  final double contentPaddingFactor;

  /// The icon which is shown inside the FAB.
  final Icon icon;

  /// The text which is shown when the FAB is expanded.
  final String text;

  /// The [TextStyle] applied to [text]
  /// Default:
  /// ```
  /// TextStyle(
  ///    fontWeight: FontWeight.bold,
  ///    color: Colors.white,
  ///    fontSize: 15,
  ///  ),
  /// ```
  final TextStyle textStyle;

  /// The [Color] which is applied to the background of the FAB.
  /// [backgroundColor] and [backgroundGradient] both can't be null
  /// [backgroundColor] and [backgroundGradient] both can't be defined together.
  final Color? backgroundColor;

  /// The [Gradient] which is applied to the background of the FAB.
  /// [backgroundColor] and [backgroundGradient] both can't be null
  /// [backgroundColor] and [backgroundGradient] both can't be defined together.
  final Gradient? backgroundGradient;

  /// This controls the size of the shadow below the floating action button.
  // Defaults to 6, the appropriate elevation for floating action buttons. The value is always non-negative.
  final double elevation;

  @override
  _AnimatedFABState createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late Animation<double> width;
  late AnimationController controller;
  late ScrollDirection lastScrollDirection;

  final double _diameter = 56;
  final Duration _animDuration = Duration(milliseconds: 300);
  final double _borderRadius = 40;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: _animDuration);
    width = Tween<double>(
      end: widget.maxWidth,
      begin: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    widget.scrollController.addListener(() async {
      lastScrollDirection =
          widget.scrollController.position.userScrollDirection;
      var dir = widget.scrollController.position.userScrollDirection;
      _animate(dir);
    });
    super.initState();
  }

  Future _animate(ScrollDirection scrollDirection) async {
    switch (scrollDirection) {
      case ScrollDirection.idle:
        _animate(lastScrollDirection);
        break;
      case ScrollDirection.reverse:
        controller.reverse();
        break;
      case ScrollDirection.forward:
        controller.forward();
        break;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(_borderRadius),
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: width,
        builder: (context, child) {
          return Container(
            width: width.value + _diameter,
            height: _diameter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              color: widget.backgroundColor,
              gradient: widget.backgroundGradient,
            ),
            child: Center(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: OverflowBox(
                      child: Center(
                        child: SizeTransition(
                          sizeFactor: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: AnimatedOpacity(
                                  child: Text(
                                    widget.text,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.clip,
                                    style: widget.textStyle,
                                    maxLines: 1,
                                  ),
                                  opacity: width.value / widget.maxWidth,
                                  duration: Duration(milliseconds: 10),
                                ),
                              ),
                              SizedBox(
                                width: _diameter / 3.5,
                              ),
                              SizedBox(
                                width:
                                    width.value * widget.contentPaddingFactor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Container(
                          child: widget.icon,
                          margin: EdgeInsets.symmetric(
                            horizontal: _diameter / 3.5,
                          ),
                          padding: EdgeInsets.only(
                            left: width.value * widget.contentPaddingFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        onTap: widget.onTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
