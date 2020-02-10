![](https://github.com/muldec/flavor_banner/workflows/CI/badge.svg) [![codecov](https://img.shields.io/codecov/c/github/Muldec/flavor_banner/master?label=coverage%20%28master%29)](https://codecov.io/gh/Muldec/flavor_banner)

# flavor_banner

Provides a widget to display a tappable banner in the top left part of 
your app to show a dialog with the device information.

## Getting Started

After importing this plugin to your project as usual, simply wrap your 
main widget with a `FlavorBanner` and provide it with a `FlavorConfig`.

```dart
void main() {
  return runApp(MyApp());
}
    
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavor Banner Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlavorBanner(
        child: MyHomePage(title: 'Flavor Banner Demo Home Page'),
        flavorConfig: FlavorConfig(
          flavor: Flavor.DEV,
          color: Colors.green,
        ),
      ),
    );
  }
}    
```

