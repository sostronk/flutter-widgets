import 'package:flutter/material.dart';
import 'package:flutter_widgets/tilt_animated_list.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  List<Widget> users = List.generate(
    8,
    (index) => Text(
      'Tab ${index + 1}',
      key: ValueKey("tab$index"),
    ),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), () {
        final tmpListp = List<Widget>.from(users);

        debugPrint('users>> befrroe:\n$users');

        final tmp = tmpListp[1];
        tmpListp[1] = tmpListp[5];
        tmpListp[5] = tmp;

        setState(() {
          users = List<Widget>.from(tmpListp);
          debugPrint('\nusers>> after:\n$users');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilt Animated List'),
      ),
      body: TiltAnimatedList(
        key: const ValueKey('tiltAnimatedList'),
        keyingFunction: (item) => item.key!,
        items: users,
        duration: const Duration(milliseconds: 600),
        itemBuilder: (context, element) => Container(
          key: element.key,
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          height: 35,
          color: Colors.greenAccent,
          alignment: Alignment.center,
          child: element,
        ),
      ),
    );
  }
}
