import 'package:collection_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'images.dart';


class OverlayLoaderWithAppIcon extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final double appIconSize;
  final double borderRadius;
  final double overlayOpacity;
  final Color? overlayBackgroundColor;
  final Color? circularProgressColor;

  OverlayLoaderWithAppIcon({
    required this.isLoading,
    required this.child,
    this.appIconSize = 160,
    this.borderRadius = 15,
    this.overlayOpacity = 0.5,
    this.circularProgressColor,
    this.overlayBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OverLayAnimation(
      isLoading: isLoading,
      opacity: overlayOpacity,
      color: Colors.black,
      progressIndicator: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: SizedBox(
            height: 180, // Increased height to accommodate loader
            width: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: appIconSize,
                  height: appIconSize,
                  child: Image.asset(Images.splash),
                ),
                SizedBox(
                  width: appIconSize + 40, // Adjust size to fit inside the logo
                  height: appIconSize + 40,
                  child: CircularProgressIndicator(
                    backgroundColor: circularProgressColor ?? Colors.white,
                    color: brandPrimaryColor,
                    strokeWidth: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}

//OverLayAnimation class for ModalBarrier
class OverLayAnimation extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Widget child;

  const OverLayAnimation({
    required this.isLoading,
    required this.child,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  State<OverLayAnimation> createState() => _OverLayAnimationState();
}

class _OverLayAnimationState extends State<OverLayAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _OverLayAnimationState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      status == AnimationStatus.forward
          ? setState(() => {_overlayVisible = true})
          : null;
      status == AnimationStatus.dismissed
          ? setState(() => {_overlayVisible = false})
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(OverLayAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}
