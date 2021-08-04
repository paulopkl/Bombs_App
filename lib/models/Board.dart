import 'dart:math';

import 'package:bombs/models/Campo.dart';

class Board {
  final int lines;
  final int columns;
  final int qttBombs;

  final List<Campo> _campos = [];

  Board({
    required this.lines,
    required this.columns,
    required this.qttBombs,
  }) {
    _createCampos();
    _relateNeighboors();
  }

  void restart() {
    _campos.forEach((campo) => campo.restart());
    _drawMines();
  }

  void revealBombs() {
    _campos.forEach((c) => c.revealBomb());
  }

  void _createCampos() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _campos.add(Campo(line: l, column: c));
      }
    }
  }

  void _relateNeighboors() {
    for (var campo in _campos) {
      for (var neighbor in _campos) {
        campo.addNeighbor(neighbor);
      }
    }
  }

  void _drawMines() {
    int drawed = 0;

    if (qttBombs > (lines * columns)) return;

    while (drawed < qttBombs) {
      int i = Random().nextInt(_campos.length);
      if (!_campos[i].minned) {
        drawed++;
        _campos[i].minner();
      }
    }
  }

  List<Campo> get campos => _campos;

  bool get resolved => _campos.every((c) => c.resolved);
}
