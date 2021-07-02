import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final themeModeProvider = StateNotifierProvider<ThemeModeController, ThemeMode>(
    (_) => ThemeModeController(ThemeMode.light));

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(state) : super(state);

  change() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

class MyApp extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.blue),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeModeProvider),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        leading: InkWell(
          child: Icon(Theme.of(context).brightness == Brightness.light
              ? Icons.brightness_high
              : Icons.brightness_4),
          onTap: () => ref.watch(themeModeProvider.notifier).change(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'default color',
            ),
            Text(
              'Theme.of(context).primaryColor',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            Text(
              'accentColor color',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
