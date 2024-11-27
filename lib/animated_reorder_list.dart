import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';

class AnimatedReorderList<T> extends StatefulWidget {
  const AnimatedReorderList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.keyingFunction,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.duration = kThemeAnimationDuration,
  });

  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final Key Function(T item) keyingFunction;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Duration duration;

  @override
  State<AnimatedReorderList<T>> createState() => _AnimatedReorderListState<T>();
}

class _AnimatedReorderListState<T> extends State<AnimatedReorderList<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<T> localItems;
  late Map<int, Tween<Offset>> scene;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    localItems = widget.items;
    scene = {};
  }

  @override
  void didUpdateWidget(AnimatedReorderList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final List<Key> oldKeys =
        oldWidget.items.map((T e) => oldWidget.keyingFunction(e)).toList();
    final List<Key> newKeys =
        widget.items.map((T e) => widget.keyingFunction(e)).toList();
    scene = {};

    final updates = calculateListDiff<Key>(
      oldKeys,
      newKeys,
      detectMoves: true,
    ).getUpdatesWithData().toList();

    for (final DataDiffUpdate<Key> update in updates) {
      if (update is DataInsert<Key>) {
        scene[update.position] = ConstantTween(Offset.zero);
      } else if (update is DataRemove<Key>) {
        scene[update.position] = ConstantTween(Offset.zero);
      } else if (update is DataMove<Key>) {
        scene[update.to] = Tween<Offset>(
          begin: Offset(0, (-update.to + update.from).toDouble()),
          end: Offset.zero,
        );
      }
    }
    controller.forward(from: 0).whenComplete(() {
      localItems = widget.items;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      itemCount: localItems.length,
      itemBuilder: (BuildContext context, int index) {
        return SlideTransition(
          position:
              (scene[index] ?? ConstantTween(Offset.zero)).animate(controller),
          child: widget.itemBuilder(context, localItems[index]),
        );
      },
    );
  }
}
