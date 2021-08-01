import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Randomwords extends StatefulWidget {
  @override
  _RandomwordsState createState() => _RandomwordsState();
}

class _RandomwordsState extends State<Randomwords> {
  @override
  final _wordpairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        final index = item ~/ 2;

        if (index >= _wordpairs.length) {
          _wordpairs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_wordpairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
        title: Text(pair.asCamelCase),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _savedWordPairs.remove(pair);
            } else {
              _savedWordPairs.add(pair);
            }
          });
        });
  }

  void _pushsaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(title: Text(pair.asCamelCase));
      });

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();
      return Scaffold(
          appBar: AppBar(
            title: Text("saved word pairs "),
          ),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WordPairGenerator"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushsaved)
          ],
          centerTitle: true,
        ),
        body: _buildList());
  }
}
