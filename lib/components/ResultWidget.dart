import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  var winned;
  final void Function() onRestart;

  ResultWidget(this.winned, this.onRestart);

  Color _getColor() {
    if (winned == null)
      return Colors.yellow;
    else if (winned)
      return Colors.green.shade300;
    else
      return Colors.red.shade300;
  }

  IconData _getIcon() {
    if (winned == null)
      return Icons.sentiment_satisfied;
    else if (winned)
      return Icons.sentiment_very_satisfied;
    else
      return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onRestart,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
