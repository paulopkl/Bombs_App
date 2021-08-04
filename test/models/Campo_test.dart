import 'package:bombs/models/Campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Campo", () {

    test("Open Campo With Explosion", () {
      Campo c = Campo(line: 0, column: 0);

      c.minner();

      expect(c.open, throwsException);
    });

    test("Open Campo Without Explosion", () {
      Campo c = Campo(line: 0, column: 0);

      c.open();

      expect(c.openned, isTrue);
    });

    test("Add Not neighbor", () {
      Campo c1 = Campo(line: 0, column: 0);
      Campo c2 = Campo(line: 1, column: 3);
      
      c1.addNeighbor(c2);

    });

    test("Add neighbor", () {
      Campo c1 = Campo(line: 3, column: 3);
      Campo c2 = Campo(line: 3, column: 4);
      Campo c3 = Campo(line: 2, column: 2);
      Campo c4 = Campo(line: 4, column: 4);
      
      c1.addNeighbor(c2);
      c1.addNeighbor(c3);
      c1.addNeighbor(c4);

      expect(c1.neighbors.length, 3);
    });
    
    test("Mines in neighborhood", () {
      Campo c1 = Campo(line: 3, column: 3);

      Campo c2 = Campo(line: 3, column: 4);
      c2.minner();

      Campo c3 = Campo(line: 2, column: 2);

      Campo c4 = Campo(line: 4, column: 4);
      c4.minner();
      
      c1.addNeighbor(c2);
      c1.addNeighbor(c3);
      c1.addNeighbor(c4);

      expect(c1.qttMinesInNeighborhood, 2);
    });
  });
}