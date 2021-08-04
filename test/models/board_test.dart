import 'package:bombs/models/Board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Win Game', () {
    Board board = Board(
      lines: 2,
      columns: 2,
      qttBombs: 0,
    );

    board.campos[0].minner();
    board.campos[3].minner();

    // Playing...
    board.campos[0].alterMark();
    board.campos[1].open();
    board.campos[2].open();
    board.campos[3].alterMark();

    expect(board.resolved, isTrue);
  });
}
