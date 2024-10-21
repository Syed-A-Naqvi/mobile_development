import 'dart:math';
import 'package:test/test.dart';

// In Dart, only declarations can be made outside of a function
// executable statements such as function calls, loops and assignments must exist within a function

void main(){

  // --------------------------------------- VARIABLES AND TYPES ---------------------------------------

  // Primitive types
    // statically-typed variables
    bool signal = true;
    int number = 10;
    double f_num= 10.5;
    String word = "car";

  // type inferenced variables
    // type => string
    // type is now fixed
    var value = 'dart';

    // statically typed variables have a fixed type known by the compiler before runtime.
    // This prevents type errors and can improve optimization at runtime.

  // Dynamically typed variables
    // used the dynamic keyword
    // can reassign to a value of a different type
    dynamic d_value = 10;
    d_value = "word";

  // const and final
    // const is compile-time-constant. A value that must be known by the compiler at compile time.
    // final is runtime-constant. A field value that can be uknown at compile time and determined at runtime.

    // const must be konwn before runtime
    const c_value = 10;

    //final can be calculated AT runtime but can only be set ONCE
    final f_value = DateTime.now();
    final f2_value = ((10-3)~/7);
    // we can see that DateTime.now() returns a value that can only be known at runtime which is why we need final

  // print("Const value is ${c_value}\nWhile current time is ${f_value}\nCalculated value is ${f2_value}");

  // --------------------------------------- VARIABLES AND TYPES ---------------------------------------


  // --------------------------------------- LISTS, MAPS AND LOOPS ---------------------------------------

  // Lists
    // very similar to dynamically-sized lists in java (arraylist)

    // this creates a homogeneous list
    List<double> grades = [46.5, 64.0, 71.5, 68.0, 76.0, 70.0, 62.3];
    print(grades);

    // this creates a heterogeneous list
    List<dynamic> things = [12, 3.5, 'cat', "dog", 3];
    print(things);

    things.add(3.5);
    things.remove("cat");
    things[1] = things[1].toString();
    print(things);
    print(things[1].runtimeType);

  // List functions

    // returns a lazy iterable of the first 2 elements of things
    // iteraties through the lazy sequence and applies a lambda function to each element
    things.take(2).forEach((item) => print(item));

    // List<int> variable
    // type is inferred
    var values = [4, 2, 5, 1, 3];
    // uses a lambda function to determine sort order
      // a is the left element and b is the right element
      // if a-b < 0 a comes before b
      // if a-b = 0 a is the same as b and order unchanged
      // if a-b > 0 a comes after b
    values.sort((a, b) => a-b);
    print(values);

    // reduce is a list method that 'reduces' all elements of a list to a single value
      // reduce applies a lambda function to the first two values in the list and returns a single result value
      // the lambda then takes the result as its first argument and the third list element as its second argument returning a single value again
      // it again takes the returned value as its first argument and the 4th value as its second and continues until the end of the list
      // the list remains unchanged
    print(values.reduce((a,b) => a+b));
    print(values);

    // every applies a lambda function to each element in iteration order and returns true if the test passes for all elements
    // else returns false
    print(values.every((number) => number < 10));

    // map applies a transformation to each element of a list, mapping it to a transformed version and returning a lazy iterable
    // the transformations are applied on-the-fly as the lazy iterable is iterated
    // the toList method can be used on the returned lazy iterable to realize the transformed list
    print(grades.map((x)=> pow(x,2)));

    // where returns a lazy iterable consisting of only those elements satisfying the predicate 
    print(grades.where((grade) => grade > 70));

    // anonymous function applied to each element using forEach method
    // each elemet is passed to the 'item' parameter
    things.forEach((element) => print("$element is a ${element.runtimeType}"));

  // Loops
    // standard for loop
    for(int i = 0; i < things.length; i++)
    {
      print("Element number ${i+1} = ${things[i]}");
    }
    print("");

    // standard while loop
    int j = 0;
    while(j < things.length)
    {
      print("Element number ${j+1} = ${things[j]}");
      j++;
    }
    print("");

    // standard for do-while
    j = 0;
    do {
      print("Element number ${j+1} = ${things[j]}");
      j++;
    } while (j < things.length);
    print("");

    // standard for-each loop
    for (dynamic thing in things)
    {
      print("thing = $thing, thing type = ${thing.runtimeType}");
    }
    
    //creating a new null valued dynamic list
    List<dynamic> things2;
    //sets things2 as a shallow copy of things
      // they now both refer to the same list in memory
    things2 = things;

    //they are the same
    print("$things type is ${things.runtimeType}");
    print("$things2 type is ${things2.runtimeType}");

    // 3rd element of both things2 and things is now 4
    things2[3] = 4;

    // verify change from both references
    print(things);
    print(things2);

    // set things 2 as an empty list
      // things2 is now a reference to different block of memory
    things2 = [];
    //using a lambda function to insert each item of things into things2
      // since each element of things is primitive, things2 will contain deep copies and not references
    things.forEach((item) => things2.add(item));

    things2[3] = 3;
    
    // they are different
    print(things);
    print(things2);

    

  // Maps

    // the same as dictionaries, hashmaps and hashtables
    Map<String, double> gmap = {
      '101': 46.1,
      '102': 68.4,
      '103': 98.1,
    };
    // replace value for the given key
    gmap['101'] = 50.0;
    // inserting a new key-value pair
    gmap['104'] = 80.0;
    print(gmap['104']);

  // --------------------------------------- LISTS, MAPS AND LOOPS ---------------------------------------


  // --------------------------------------- FUNCTIONS ---------------------------------------

  // functions can also be typed by inference
  square(dynamic a)
  {
    return a * a;
  }
  num result = square(3.0);
  print(result); // -> 9.0

  // dart functions also support default arguments
  cube([double a = 2])
  {
    return a * a * a;
  }
  print(square(3)); // -> 9
  print(cube()); // -> 8.0

  int factorial({int? a})
  {
    a = ((a == null) ? 10 : a);
    int fac = 1;
    for(int i = 2; i < (a+1); i++)
    {
      fac *= i;
    }
    return fac;
  }
  print(factorial());

  // dart supports named arguments to make the parameters being set more clear
    // named arguments can be provided in any order and are optional
    // they therefore require a default value, or need the 'required' keyword to enforce their provision
  double doubleNum({num x = 1})
  {
    return 2.0 * x;
  }
  print(doubleNum(x: 5));
      
  // lambda functions
    // short inline functions, best for single lines of code in function body, when the return value is a single expression
    // the final keyword is requried instead of the const keyword because a lambda function is not a compile-time-constant
  final sqr = (x) => x*x;
  final cbe = (x) => pow(x, 3);
  Function power = sqr;
  print(power(3));

  // anonymous functions are the multi-line version of lambda functions
  final printUser = (fname, lname) {
    print("Firstname: $fname");
    print("Lasttname: $lname");
  };

  printUser("mei", "yui");

  // --------------------------------------- FUNCTIONS ---------------------------------------


  // --------------------------------------- EXCEPTIONS ---------------------------------------

  // very similar to other programming languages
  // tries to execute a block of code and catches an exception if there is an error
  String userInput = '2.34.3';
  double nummm = 0.0;
  try
  {
    nummm = double.parse(userInput);
  }
  on FormatException catch (e)
  {
    print('Invalid number: $userInput');
    print(e);
  }
  catch (ex)
  {
    print("Soemthing went wrong");
    print(ex);
  }
  print(nummm);

  // if the exception type is not known can use a generaic try-catch block
  values = [1,2,3,4];
  int idx = 4;
  try {
    print(values[idx]);
  } catch (e) {
    print("invalid index");
    print(e);
  }

  // --------------------------------------- EXCEPTIONS ---------------------------------------


  // --------------------------------------- TESTING ---------------------------------------
  // if working in a flutter project, can test to see whether the output of a block of code provides expected output
  var sales = [1,2,3,4,5];
  expect(sales.reduce((a, b) => a + b), 15);
  sales = [];
  expect(sales.reduce((a, b) => a + b), 0);
  // --------------------------------------- TESTING ---------------------------------------


}


  

