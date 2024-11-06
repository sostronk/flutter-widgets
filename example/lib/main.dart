import 'package:example/animated_list_screen.dart';
import 'package:example/skewed_tab_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flexible_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            FlexibleText(
              text: 'Hello :World:~1~',
              style: const TextStyle(color: Colors.black),
              richStyles: const [TextStyle(color: Colors.red)],
              textRecognizers: [
                TapGestureRecognizer()
                  ..onTap = () {
                    debugPrint('World tapped');
                  }
              ],
              widgets: const [
                Icon(Icons.star),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavigationCTA(
                  text: 'Skewed Tab',
                  onPressed: () => ModalRoute.of(context)?.navigator?.push(
                        MaterialPageRoute(
                          builder: (context) => const SkewedTabScreen(),
                        ),
                      ),
                ),
                _NavigationCTA(
                  text: 'Animated List',
                  onPressed: () => ModalRoute.of(context)?.navigator?.push(
                        MaterialPageRoute(
                          builder: (context) => const AnimatedListScreen(),
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _NavigationCTA extends StatelessWidget {
  const _NavigationCTA({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      child: Text(text),
    );
  }
}
