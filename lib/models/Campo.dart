import 'package:bombs/models/ExplosionException.dart';

class Campo {
  final int line;
  final int column;
  final List<Campo> neighbors = [];

  bool _openned = false;
  bool _marked = false;
  bool _minned = false;
  bool _exploded = false;

  Campo({
    required this.line,
    required this.column,
  });

  void addNeighbor(Campo neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_openned) {
      return;
    }

    _openned = true;

    if (_minned) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbors.forEach((n) => n.open());
    }
  }

  void revealBomb() {
    if (_minned) {
      _openned = true;
    }
  }

  void minner() {
    _minned = true;
  }

  void alterMark() {
    _marked = !_marked;
  }

  void restart() {
    _openned = false;
    _marked = false;
    _minned = false;
    _exploded = false;
  }

  bool get minned => _minned;

  bool get exploded => _exploded;

  bool get openned => _openned;

  bool get marked => _marked;

  bool get resolved {
    bool minnedAndMarked = minned && marked;
    bool safeAndOpenned = !minned && openned;

    return minnedAndMarked || safeAndOpenned;
  }

  bool get safeNeighborhood {
    return neighbors.every((n) => !n._minned);
  }

  int get qttMinesInNeighborhood {
    return neighbors.where((n) => n.minned).length;
  }
}
