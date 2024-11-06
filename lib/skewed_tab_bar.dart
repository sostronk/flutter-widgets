import 'package:flutter/material.dart';

class SkewedTabBar extends StatefulWidget {
  const SkewedTabBar({
    super.key,
    required this.tabs,
    required this.views,
    this.initialIndex = 0,
    this.tag,
    this.physics,
    this.tabController,
    this.tabHeight,
    this.borderWidth,
    this.indicatorWeight,
    this.tabBarActiveTextColor = Colors.white,
    this.tabBarInactiveTextColor = const Color(0xFF555E65),
    this.selectedTabColor = const Color(0xFF1F2731),
    this.inactiveTabColor = const Color(0xFF222B35),
    this.borderColor = const Color(0xFFF5AA38),
  });
  final List<Widget>? views;
  final List<Widget> tabs;
  final int initialIndex;
  final ScrollPhysics? physics;
  final String? tag;
  final TabController? tabController;
  final double? tabHeight;
  final double? borderWidth;
  final double? indicatorWeight;
  final Color tabBarInactiveTextColor;
  final Color tabBarActiveTextColor;
  final Color selectedTabColor;
  final Color inactiveTabColor;
  final Color borderColor;

  @override
  State<SkewedTabBar> createState() => _SkewedTabBarState();
}

class _SkewedTabBarState extends State<SkewedTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;
  late int initialIndex;
  @override
  void initState() {
    super.initState();
    initialIndex = widget.initialIndex;
    tabController = widget.tabController ??
        TabController(
          initialIndex: widget.initialIndex,
          length: widget.tabs.length,
          vsync: this,
        );
    tabController.addListener(_onTabIndexChange);
  }

  @override
  void dispose() {
    tabController.removeListener(_onTabIndexChange);
    tabController.dispose();
    super.dispose();
  }

  void _onTabIndexChange() {
    setState(() {
      initialIndex = tabController.index;
    });
    ;
  }

  @override
  void didUpdateWidget(SkewedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      tabController.removeListener(_onTabIndexChange);
      tabController.dispose();
      tabController = TabController(length: widget.tabs.length, vsync: this);
      tabController.addListener(_onTabIndexChange);
    }
  }

  EdgeInsets get indicatorPadding {
    if (initialIndex == 0) {
      return EdgeInsets.zero;
    }

    return EdgeInsets.only(
        left: (18 - ((widget.tabs.length - initialIndex) * 5)));
  }

  Color color(int index) {
    if (initialIndex == index) {
      return widget.selectedTabColor;
    }
    return widget.inactiveTabColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          indicatorWeight: widget.indicatorWeight ?? 7,
          dividerColor: Colors.transparent,
          indicatorPadding: indicatorPadding,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: widget.borderWidth ?? 10,
                color: widget.borderColor,
              ),
            ),
          ),
          labelPadding: EdgeInsets.zero,
          unselectedLabelColor: widget.tabBarInactiveTextColor,
          labelColor: widget.tabBarActiveTextColor,
          tabs: widget.tabs.asMap().entries.map(
            (e) {
              return Tab(
                height: widget.tabHeight ?? 25,
                child: CustomPaint(
                  painter: TabPainter(
                    color: color(e.key),
                    index: e.key,
                    tabsCount: widget.tabs.length,
                  ),
                  child: Center(
                    child: e.value,
                  ),
                ),
              );
            },
          ).toList(),
        ),
        if (widget.views != null)
          Expanded(
            child: TabBarView(
              physics: widget.physics,
              controller: tabController,
              children: widget.views!,
            ),
          ),
      ],
    );
  }
}

class TabPainter extends CustomPainter {
  const TabPainter({
    required this.color,
    required this.index,
    required this.tabsCount,
  });
  final Color color;
  final int index, tabsCount;
  @override
  void paint(Canvas canvas, Size size) {
    final isFirst = index == 0;
    final isLast = index == tabsCount - 1;
    Paint box = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Path boxPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.9, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..close();
    Path startBoxPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..close();
    Path endBoxPath = Path()
      ..moveTo(size.width * 0.9, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(boxPath, box);
    if (isFirst) {
      canvas.drawPath(startBoxPath, box);
    } else if (isLast) {
      canvas.drawPath(endBoxPath, box);
    }
  }

  @override
  bool shouldRepaint(covariant TabPainter oldDelegate) =>
      color != oldDelegate.color;
}
