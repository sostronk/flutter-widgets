# Flutter Widgets

## Flexible Text

FlexibleText is a Flutter widget that allows you to seamlessly mix and match rich text segments and widgets within a single text block. Customize your text with different styles and gestures, and insert inline widgets using simple placeholders. This powerful and flexible solution makes it easy to create dynamic, interactive, and visually appealing text in your Flutter applications.
 
#### Usage 📝

```dart
FlexibleText(
  text: 'Hello :World:~1~~star~',
  style: TextStyle(color: Colors.black),
  richStyles: [TextStyle(color: Colors.red)],
  textRecognizers: [TapGestureRecognizer()..onTap = () { print('World tapped'); }],
  namedWidgets: {'star': Icon(Icons.star)},
  widgets: [Icon(Icons.star)],
);
```

Above snippet will give following output

<p align="center">
  <img src="assets/image.png" />
</p>


## Skewed TabBar

As the name suggests Skewed TabBar allows you to create a tab bar with skews

#### Usage 📝

```dart
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
```
Above snippet will give following output

<p align="center">
  <img src="assets/skewed_tab_bar.gif" />
</p>

## Tilt Animated List

As the name suggests Skewed TabBar allows you to create a tab bar with skews

#### Usage 📝

```dart
TiltAnimatedList(
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
      )
```
When the indexing of list items updates,

```dart
  final tmpListp = List<Widget>.from(users);

        debugPrint('users>> befrroe:\n$users');

        final tmp = tmpListp[1];
        tmpListp[1] = tmpListp[5];
        tmpListp[5] = tmp;

        setState(() {
          users = List<Widget>.from(tmpListp);
          debugPrint('\nusers>> after:\n$users');
        });
```
TiltAnimatedList will animate and adjust the indexing

<p align="center">
  <img src="assets/animated_list.gif" />
</p>