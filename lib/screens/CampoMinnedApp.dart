import 'package:bombs/components/BoardWidget.dart';
import 'package:bombs/components/CampoWidget.dart';
import 'package:bombs/components/ResultWidget.dart';
import 'package:bombs/models/Board.dart';
import 'package:bombs/models/Campo.dart';
import 'package:bombs/models/ExplosionException.dart';
import 'package:flutter/material.dart';

class CampoMinnedApp extends StatefulWidget {
  @override
  _CampoMinnedAppState createState() => _CampoMinnedAppState();
}

class _CampoMinnedAppState extends State<CampoMinnedApp> {
  var _winned;
  var _board;

  void _restart() {
    setState(() {
      _winned = null;
      _board.restart();
    });
  }

  void _open(Campo c) {
    if (_winned == true) return;

    setState(() {
      try {
        c.open();
        if (_board.resolved) {
          _winned = true;
        }
      } on ExplosionException {
        _winned = false;
        _board.revealBombs();
      }
    });
  }

  void _alterMark(Campo c) {
    if (_winned != null) return;

    setState(() {
      c.alterMark();

      if (_board.resolved) {
        _winned = true;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int qttColumns = 15;
      double fieldSize = width / qttColumns;
      int qttLines = (height / fieldSize).floor();

      _board = Board(
        lines: qttLines,
        columns: qttColumns,
        qttBombs: 50,
      );
    }

    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultWidget(
          _winned,
          _restart,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onAlterMark: _alterMark,
              );
            },
          ),
        ),
      ),
    );
  }
}
