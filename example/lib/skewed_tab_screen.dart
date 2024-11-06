import 'package:flutter/material.dart';
import 'package:flutter_widgets/skewed_tab_bar.dart';

class SkewedTabScreen extends StatelessWidget {
  const SkewedTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs =
        List.generate(3, (index) => Text('Tab ${index + 1}'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skewed Tab Bar'),
      ),
      body: SkewedTabBar(
        tabs: tabs,
        views: tabs
            .map(
              (e) => Container(
                color: Colors.greenAccent,
                alignment: Alignment.center,
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
