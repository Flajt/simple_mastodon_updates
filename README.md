A Mastodon feed parser for the `flutter_simple_update` package. Allows you to easily post your Mastodon updates as notifications in your app.

## Features

- Parsing your mastodon feed
- Works as extension for [flutter_simple_update](https://pub.dev/packages/flutter_simple_updates)
## Getting started

- Install the main package `flutter pub add flutter_simple_updates`
- Install this package `flutter pub add simple_mastodon_updates`
- Add your feed as shown in the examle below
- Decide on a trigger element (in the example case it's `!`), this needs to be the <**first** character/string of your post!

> Trigger: A trigger is a way to notifiy the package to display a post. This way you can still post things on your account that can't reach your app users if you want.

## Usage

```dart

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final SimpleMastodonParser parser =
      SimpleMastodonParser("!", "https://mastodon.world/<your-tag-here>");// Included in this package!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NotificationWidget( // Not in this package! Head over to the flutter_simple_updates package!
          cache: HiveCacheWrapper(), // Not in this package! Head over to the flutter_simple_updates package!
          feedProvider: parser,
        ),
      ),
    );
  }
}

```

## Additional information
- Check out the main package for other parsers or if you want to implement your own.
