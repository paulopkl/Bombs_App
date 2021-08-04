import 'package:bombs/components/CampoWidget.dart';
import 'package:bombs/models/Board.dart';
import 'package:bombs/models/Campo.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Campo) onOpen;
  final void Function(Campo) onAlterMark;

  BoardWidget({
    required this.board,
    required this.onOpen,
    required this.onAlterMark,
  });

  _getCount() {
    if (board.columns != 0)
      return board.columns;
    else
      return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: _getCount(),
        children: board.campos
            .map((c) => CampoWidget(
                  campo: c,
                  onOpen: onOpen,
                  onAlterMark: onAlterMark,
                ))
            .toList(),
      ),
    );
  }
}
