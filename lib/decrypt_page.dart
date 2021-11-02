import 'package:flutter/material.dart';

class DecryptPage extends StatefulWidget {
  const DecryptPage({Key? key}) : super(key: key);

  @override
  _DecryptPageState createState() => _DecryptPageState();
}

class _DecryptPageState extends State<DecryptPage> {
  String? _string, _decryptedString;
  bool _isDecrypting = false;

  void _decrypt(BuildContext context, String? string) {
    setState(() {
      _isDecrypting = true;
    });
    _decryptedString = '';

    if (string!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter some Input"),
        duration: Duration(milliseconds: 1000),
      ));
      setState(() {
        _isDecrypting = false;
      });
      return;
    }

    if (string.length % 2 != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Input Format is wrong"),
        duration: Duration(milliseconds: 1000),
      ));
      setState(() {
        _isDecrypting = false;
      });
      return;
    }

    for (int i = 0; i < string.length; i++) {
      final rune = string.codeUnitAt(i);
      var character = String.fromCharCode(rune);
      if (i % 2 != 0) {
        if (int.tryParse(character) == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Input Format is wrong"),
            duration: Duration(milliseconds: 1000),
          ));
          setState(() {
            _isDecrypting = false;
          });
          return;
        }
      }
    }

    for (int i = 0; i < string.length; i++) {
      if (i % 2 != 0) {
        int num = int.tryParse(string[i]) ?? 0;

        for (int j = 0; j < num; j++) {
          final previousRune = string.codeUnitAt(i - 1);
          _decryptedString =
              _decryptedString! + String.fromCharCode(previousRune);
        }
      }
    }
    setState(() {
      _isDecrypting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Decrypt String'),
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
              child: _isDecrypting
                  ? const Text('Decrypting')
                  : const Text('Decrypt'),
              onPressed: _string == null
                  ? null
                  : () {
                      _decrypt(context, _string);
                    },
            ),
            if (_decryptedString != null)
              Text(
                'Decrypted String: ${_decryptedString!}',
                style: const TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
