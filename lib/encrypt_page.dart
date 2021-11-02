import 'package:flutter/material.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({Key? key}) : super(key: key);

  @override
  _EncryptPageState createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  String? _string, _encryptedString;

  int? _previousRune;
  int? _previousRuneCount;

  void _encrypt(String? string) {
    _encryptedString = '';
    _previousRune = null;
    _previousRuneCount = 0;

    string?.runes.forEach((rune) {
      var character = String.fromCharCode(rune);

      if (_previousRune != null && _previousRune == rune) {
        setState(() {
          _previousRune = rune;
          _previousRuneCount = (_previousRuneCount ?? 0) + 1;

          _encryptedString = _encryptedString!
                  .substring(0, _encryptedString!.length - 1) +
              (_previousRuneCount != 0 ? _previousRuneCount.toString() : '0');
        });
      } else {
        setState(() {
          _previousRune = rune;
          _previousRuneCount = 1;
          _encryptedString = _encryptedString! + character + '1';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Encrypt String'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter String',
              ),
              onChanged: (value) {
                setState(() {
                  _string = value;
                });
              },
            ),
            ElevatedButton(
              child: const Text('Encrypt'),
              onPressed: _string == null
                  ? null
                  : () {
                      _encrypt(_string);
                    },
            ),
            if (_encryptedString != null)
              Text(
                'Encrypted String: ${_encryptedString!}',
                style: const TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
