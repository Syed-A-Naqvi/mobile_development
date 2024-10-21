import 'dart:ffi';

void main() {
  //VARIABLES *******************
  String var1 = "ali";
  String var2 = 'ali';
  int x = 20;
  bool b = true;
  double mynumber = 3;
  //mynumber = "ali" -> this will generate an error because mynumber is statically typed as double
  print(mynumber + 1); //A? = 4
  print(mynumber++);   //B? = 3
  print(mynumber);     //C? = 3

  //static/hybrid
  var varx = "Dart";
  //varx = 20;  // this will cause an error since varx has a fixed infered type of String

  dynamic var3 = "dart3";
  //var3 = 40;   //this will cause an error since varx has a fixed infered type of String
  print(var3);


  //CONSTANTS*******************
  const language = "Dart"; //at compile time

  final name = "ali"; //run time and
  //difference between final and cost?
    // final is runtime constant, its value can be unknown at compile time and be determined at runtime after which it is fixed
      // ex. final time = DateTime.now();
    // const must be a primitive value known at compile time
      // ex. const time = 'now';

  final name2 = getName(); //at run time
  //name2 = "H"; //this is not allowed since name2 is fized once it is assigned the returned value of getName();

  //List / Array ***************
  List<double> grades = [46.5, 64.0, 71.5, 68.0, 76.0, 70.0, 62.3]; // 0 or 1 indexed? -> 0 indexed
  grades.add(91.0); // add an element to the end of list
  grades.insert(6,87.2); //add to specific index
  print(grades[2]); // prints 71.5 - cast to String
  print(grades[2].toString()); //cast to String
  grades.removeAt(1); // removes 64.0 --- index

  //For Loop ***************************
  String var4 = 'ali${2+3}';
  for (int i = 0; i < 5; i++) {
    print("hello ${i + 2 *
        3} fill in your sentence with any $i variable"); //$ convert to string
  }

  //List<String> names = ["Michael", "Alex", "Alex2", "Aria", 3]; //will give error unless '3' is used
  List<String> names = ["Michael", "Alex", "Alex2", "Aria", "Ali"];


// While loop ************************
  int j = 0;
  while (j < grades.length) {
    print('${grades[j]}');
    j++;
  }

  // Example with 'break'
  print('Using break:');
  for (int i = 0; i < 5; i++) {
    if (i == 3) {
      break; // Breaks out of the loop when i is 3
    }
    print(i); // Output:0,1,2
  }

  // Example with 'continue'
  print('\nUsing continue:');
  for (int i = 0; i < 5; i++) {
    if (i == 2) {
      continue; // Skips the iteration when i is 2
    }
    print(i); // Output: 0,1,3,4
  }


  //foreach ****************************
  for (String name in names) {
    print(name);
  }

  print(names.toString()); //prints the entire list

  //Anonymous Function
  print("forEach ************* Using Anonymous Function  ************");
  names.forEach(print); //  what does it do?

  names.forEach((String name) => print(name[0])); //1 line of code - everything in one command - Lambda Function
  names.forEach((String name) { //multiple lines of commands - function
     print("Here is a name:");
     print(name);
   });


  //MAP function **************************************
  print("MAP Function ********************** ");
  //what does map do?
  List<String> names2 = names.map((name) => '*$name*').toList(); // explain? Output type??
  print(names2);

  //REDUCE function ***********************************
  print("Reduce Function ********************** ");
  //combine elements of the list to 1
  List<int> numbers = [1,2,3,4,5];
  int product = numbers.reduce( (a,b) => a*b); // output?
  print(product);


  //MAP (data type) ***************************************** Dictionary /key/value
  Map<String,dynamic> wordCount = { //type is required!
    'the': 18,
    'dog': 5,
    'michael': 'doesn\'t show up'
  };

  //how to access an element
  print(wordCount['the']); //18

  //remove function
  Map<String, int> map = {'a': 1, 'b': 2, 'c': 3};
  int? removedValue = map.remove('x');
  print(map); // Output: {a: 1, c: 3}
  print(removedValue); // Output: 2

  //ContainsKey function
  Map<String, int> mymap = {'a': 1, 'b': 2, 'c': 3};
  print(mymap.containsKey('b')); // Output: true
  print(mymap.containsKey('z')); // Output: false

  //ContainsValue function
  print(mymap.containsValue(2)); // Output: true
  print(mymap.containsValue(10)); // Output: false


  //WHERE ******************************************
  print("Where Function ********************** ");
  List<String> a_names = names.where( (n) { //function
    if (n[0] == 'A'){
      return true;
    }
    return false;
  }
  ).toList();


  print(a_names);

  bool flag = true;
  while (flag) {
    print("\nTest");
    flag = false;
  }
}// end of Main

String getName() {
  return "Ali";
}

double getNum(double a) {
  return (a*2);
}

//default arguments   ************
double square([double a = 0.0]) {
  return a * a;
}
//print(square(3.0)); // 9
//print(square());    // 0

//named arguments **********
double doubleNum({double t = 4}) {
  return 2 * t;
}
//print(doubleNum(t: 3.0)); //


void greet(String name, {String message = "Welcome", int year = 2024}) {
  print('$message, $name! The year is $year.');
}

// void main() {
//   // Calling the function without optional arguments
//   greet('Ali');
//   // Output: Welcome, Ali! The year is 2024.
//
//   // Calling the function with named arguments
//   greet('Ali', message: 'Hello', year: 2023);
//   // Output: Hello, Ali! The year is 2023.
//
//   // Calling the function with only one named argument
//   greet('Ali', year: 2025);
//   // Output: Welcome, Ali! The year is 2025.
// }


//lambda function what is x? - 1  line of code
final sqr = (x) => x * x;
final prod = (x,y) => x * y;
//prod(2,3) //how to call it

//anonymous function - multiple lines of code
final dbl = (x) { return 2 * x; }; //can be done using a lambda function

final printUser = (user) {
  print(user.firstName);
  print(user.lastName);
};






