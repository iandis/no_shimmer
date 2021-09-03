import 'package:flutter/material.dart';
import 'package:no_shimmer/no_shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Shimmer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoShimmerExample(),
    );
  }
}

typedef ItemBuilderCallback = Widget Function(BuildContext context, int index);

class NoShimmerExample extends StatelessWidget {
  const NoShimmerExample({Key? key}) : super(key: key);

  static const int _dataLength = 20;

  Future<List<List<String>>> _delayedText() {
    return Future<List<List<String>>>.delayed(
      const Duration(seconds: 5),
      () => List<List<String>>.generate(
        20,
        (i) => [
          'No Shimmer Title $i',
          'Delayed No Shimmer Subtitle $i',
        ],
      ),
    );
  }

  Widget _tile(Widget title, Widget subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        subtitle,
        const Divider(),
      ],
    );
  }

  ItemBuilderCallback _buildTextTile(List<List<String>> data) {
    return (context, index) {
      final String titleText = data[index].first;
      final String subtitleText = data[index].last;

      final Widget title = Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          titleText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      final Widget subtitle = Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          subtitleText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      );
      return _tile(title, subtitle);
    };
  }

  ItemBuilderCallback _buildNoShimmer() {
    return (context, index) {
      const Widget title = NoShimmer(
        height: 20,
        width: 110,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        padding: EdgeInsets.only(top: 5),
      );

      const Widget subtitle = NoShimmer(
        height: 15,
        width: 140,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        padding: EdgeInsets.only(top: 5),
      );
      return _tile(title, subtitle);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Shimmer Example'),
      ),
      body: FutureBuilder(
        future: _delayedText(),
        builder: (context, snapshot) {
          final ItemBuilderCallback itemBuilder;

          if (snapshot.connectionState == ConnectionState.done) {
            final List<List<String>> data =
                snapshot.data! as List<List<String>>;
            itemBuilder = _buildTextTile(data);
          } else {
            itemBuilder = _buildNoShimmer();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
            itemBuilder: itemBuilder,
            itemCount: _dataLength,
          );
        },
      ),
    );
  }
}
