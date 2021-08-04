import 'package:bombs/models/Campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onOpen;
  final void Function(Campo) onAlterMark;

  CampoWidget({
    required this.campo,
    required this.onOpen,
    required this.onAlterMark,
  });

  Widget _getImage() {
    int qttMines = campo.qttMinesInNeighborhood;

    if (campo.openned && campo.minned && campo.exploded)
      return Image.asset("assets/images/bomba_0.jpeg");
    else if (campo.openned && campo.minned)
      return Image.asset("assets/images/bomba_1.jpeg");
    else if (campo.openned)
      return Image.asset("assets/images/aberto_$qttMines.jpeg");
    else if (campo.marked)
      return Image.asset("assets/images/bandeira.jpeg");
    else
      return Image.asset("assets/images/fechado.jpeg");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(campo),
      onLongPress: () => onAlterMark(campo),
      child: _getImage(),
    );
  }
}
