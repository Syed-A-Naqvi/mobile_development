class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);  // Constant constructor
}

void main() {

  int a = 4;
  int b = 3;
  // Creating a constant instance of Point
  const point1 = Point(10, 20);  // Instance created at compile time
  var point2 = const Point(10, 20);  // Same instance reused from compile-time constant pool
  var point3 = Point(10, 20);  // Same instance reused from compile-time constant pool

  print(point1 == point3);  // true, because they refer to the same compile-time constant
}