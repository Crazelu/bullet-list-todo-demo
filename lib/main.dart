import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final _controller = CustomTextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                maxLines: 16,
                decoration: const InputDecoration(
                  hintText: 'Start typing...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextEditingController extends TextEditingController {
  static const WidgetSpan _bullet = WidgetSpan(
    child: CircleAvatar(
      backgroundColor: Colors.purple,
      radius: 8,
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 12,
      ),
    ),
  );

  @override
  set value(TextEditingValue newValue) {
    super.value = newValue;
    if (text.isNotEmpty) {
      final offset = (text.split('\n').length) * 3;
      super.value = newValue.copyWith(
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: newValue.selection.extentOffset + offset,
          ),
        ),
      );
    }
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);

    final childrenSpans = <InlineSpan>[];

    final lineSplits = text.split('\n');

    if (text.isEmpty || lineSplits.isEmpty) {
      return TextSpan(text: text, style: style);
    }

    for (final line in lineSplits) {
      childrenSpans.add(_bullet);
      childrenSpans.add(TextSpan(text: '  $line\n', style: style));
    }

    return TextSpan(children: childrenSpans);
  }
}
