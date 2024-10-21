//object oriented programming in Dart
//Stardew Valley game : farming simulation RPG

class StardewValleyCharacter {
  // Instance variables
  String? name;//explain ?
  int? age; //public or private by default?
  int? _id; // ---- variable


  // Define static variable?
  // Static variable to keep track of the population  [?]
  static int _currentPopulation = 0;

  //constructor (short form) - what's its job?
  //can we have attribute with no value?
  //int x;
  //nullable - not assigning value
  StardewValleyCharacter(this.name, this.age) {
    // Initialize the private id variable based on the static population variable
    _id = ++_currentPopulation;
  }
  //return type of constructor?

  // constructor (long form)
  // which name is which?
  //  StardewValleyCharacter(String name, int age) {
  //        this.name = name;
  //       this.age = age;
  //  }

  // Getter for id (to access it from outside the class)
  int get id => _id!;
  //how to use it?
  // myObj.id

  //defining getters (long form)
  // int? getID()
  // {
  //   return _id;
  // }

  // Method to introduce the character
  void introduce() {
    print('Hello, I am $name, and I am $age years old.');
  }

  //defining a private method (helper method?)
  void _introducePrivate() {
    print('Hello, I am $name, and I am $age years old.');
  }

  //the default toString method on an object is not informative
  //optional - no input parameter
  @override
  String toString(){
    return "Name = $name, Age = $age, id = $_id";
  }
}
//end of class

class Crop {
  // Instance variables
  String name;
  int growthTime; // in seconds
  double value;   // in money
  int experiencePoints;

  // Constructor with optional parameters and default values
  // how to call it?
  Crop({
    this.name = 'Unknown',
    this.growthTime = 0,
    this.value = 0.0,
    this.experiencePoints = 0,
  }) {
    print('A crop named $name is being created.');
  }

  // toString method
  @override
  String toString() {
    return 'Crop: $name\nGrowth Time: ${growthTime}s\nValue: \$$value\nExperience Points Reward: $experiencePoints';
  }
}

//subclass
class Strawberry extends Crop {

  //? which name?
  Strawberry({
    String name = 'Strawberry',
    int growthTime = 3, // Default growth time: 3 seconds
    double value = 3.0,     // Default value: $3.0
    int experiencePoints = 15, // Default XP reward: 15
  }) : super(
    //left side is properties, right side is the
    //params from above
    name: name,
    growthTime: growthTime,
    value: value,
    experiencePoints: experiencePoints,
  );
//what principle of OOP? (parent/child)
// Additional methods or properties specific to strawberries can be added here.
}

class Pumpkin extends Crop {
  Pumpkin({
    String name = 'Pumpkin',
    int growthTime = 3, // Default growth time: 1 second
    double value = 5.0,      // Default value: $5.0
    int experiencePoints = 20, // Default XP reward: 20
  }) : super(
    name: name,
    growthTime: growthTime,
    value: value,
    experiencePoints: experiencePoints,
  );

// Additional methods or properties specific to pumpkins can be added here.
}

//"similar" to interface
abstract class Swimmer{
  //abstract method?
  void swim();

  // non-abstract methods - allowed?
  // void introduce() {
  //   print('Hello,');
  // }
}
//no interface - difference?



class Fish {
  // Instance variables
  String name;
  double value;   // in money
  int experiencePoints;

  // Constructor - short format
  Fish(this.name, this.value, this.experiencePoints) {
    print('A fish named $name is being created.');
  }

  // toString method
  @override
  String toString() {
    return 'Fish: $name\nValue: \$$value\nExperience Points Reward: $experiencePoints';
  }
}


abstract class randomAbstractMethod{

}

//no direct multiple inheritance
//simulate multiple inheritance - multiple abstract classes
//implements vs extends
class Sturgeon extends Fish implements Swimmer,randomAbstractMethod {
  Sturgeon({
    String name = 'Sturgeon',
    double value = 10.0,   // Default value: $10.0
    int experiencePoints = 15, // Default XP reward: 15
  }) : super(name, value, experiencePoints);

  //from abstract class
  //not implementing swim method?
  @override
  void swim() {
    print('$name is swimming gracefully.');
  }
}


class Bird {
  void fly() {
    print('Flying...');
  }
}

// mixin
// to implement multiple inheritance -
// no need for constructor
mixin Swimmern {
  void swim() {
    print('Swimming...');
  }
}
class Duck extends Bird with Swimmern {}


// methods are super important
// you can create an object of a mixin
mixin class Fisher {
  int fishCaught = 0;
  int totalExperiencePoints = 0;

  String catchFish(Fish fish) {
    fishCaught++;
    totalExperiencePoints += fish.experiencePoints;
    print('You caught a ${fish.name} worth \$${fish.value}!');
    print('You earned ${fish.experiencePoints} experience points.');

    // Output the updated stats
    print('Fish Caught: $fishCaught');
    print('Total Experience Points: $totalExperiencePoints');

    return 'You have successfully caught a ${fish.name}!';
  }
}

mixin class Farmer {
  int farmExperiencePoints = 0;
  int cropsGrown = 0;

  //Async method
  //Asynchronous: The caller immediately continues executing, and a callback is issued when the operation completes
  Future<String> readFromFile(String filename) async {
    String data = "";
    //… open the file…
    //… read the data…
    return data;
  }

  //how to use wait on Async method
  //The execution continues ONLY after the operation completes
  //String result = await readFromFile(filename); //important information you need to continue


  //Asynchronous: The caller immediately continues executing, and a callback is issued when the operation completes
  // A Future is a promise to complete an operation (a placeholder) - only async methods

  Future<String> growCrop(Crop crop) async {
    print('Planting ${crop.name}...');

    //The await keyword is one way to wait for data from an asynchronous function
    // The execution continues only after the operation completes
    // This keyword can only be used from within an async function ---  Future.delayed : wait for a few seconds

    //Future = make sure it will happen

    //await / Future
    Crop grown = await Future.delayed(Duration(seconds: crop.growthTime), () {
      print("This is inside the future delayed part.");
      return crop;
    });
    print('${grown.name} has grown!');
    cropsGrown++;
    farmExperiencePoints += grown.experiencePoints;

    print('Crops Grown: $cropsGrown');
    print('Farm Experience Points: $farmExperiencePoints');

    return 'You have successfully grown ${grown.name}!';
  }
}




//how to use mixin, inheritance, abstract classes
class Player extends StardewValleyCharacter with Farmer, Fisher implements Swimmer {
  Player(String name, int age) : super(name, age);

  //where does this come from?
  @override
  void swim() {
    print('$name is swimming gracefully.');
  }

  Future<String> farmWork(Crop crop) async {
    //from farmer mixin
    return growCrop(crop);
  }
}

//**********************************************
//**********************************************
//**********************************************
void main() async {

  // Create character instances
  var character1 = StardewValleyCharacter('Alex', 28);
  var character2 = StardewValleyCharacter('Emily', 25);
  var character3 = StardewValleyCharacter('Sam', 20);
  var character4 = StardewValleyCharacter('Abigail', 22);

  // Introduce the characters
  character1.introduce();
  character2.introduce();
  character3.introduce();
  character4.introduce();

//   print(character1);

//   // Create crop instances with parameters in any order
  var crop1 = Crop(name: 'Carrot', value: 2.5, growthTime: 60 * 3);
  var crop2 = Crop(growthTime: 60 * 2, name: 'Tomato');
  var crop3 = Crop(experiencePoints: 5, name: 'Potato');

//   // Print the crop information using the toString method
  print(crop1.toString());
  print(crop2.toString());
  print(crop3.toString());

//   // Create a Sturgeon instance
  var sturgeon = Sturgeon();

//   // Print the sturgeon information and make it swim
  print(sturgeon.toString());
  sturgeon.swim();

//   // Create a Fisher instance
  var fisher = Fisher();

//   // Create some fish instances
  var rainbowTrout = Fish('Rainbow Trout', 7.5, 12);

//   // Fisher catches fish - mixin
  fisher.catchFish(rainbowTrout);
  fisher.catchFish(sturgeon);

//   // Create a Farmer instance
  var farmer = Farmer();

//   // Create a crop instance (e.g., a strawberry)
  var strawberry = Strawberry();

//   // Simulate growing a crop asynchronously
  var grownCrop = await farmer.growCrop(strawberry);

  // print('Done growing ${grownCrop.name}!');

  String? nullableString = "Hello, Dart!"; // Nullable string
  String nonNullableString = "Hello, Dart!"; // Non-nullable string

  print(nullableString?.toUpperCase()); // Using null-aware operator
  print(nonNullableString.toUpperCase()); // No issues here

  int? x; // Nullable integer
  // int y = x; // This would result in a compilation error because x can be null.

  // Create a Player instance
  var player = Player('Alex', 20);

  // Create some crop and fish instances
  Strawberry strawberry2 = Strawberry();
  Pumpkin pumpkin = Pumpkin();
  Fish rainbowTrout2 = Fish('Rainbow Trout', 7.5, 12);

  // Player performs farm work (growing crops)
  //var farmWorkResult = await player.farmWork(strawberry);
  var farmWorkResult = player.farmWork(strawberry2);

  farmWorkResult = player.farmWork(pumpkin);

  // Player catches fish
  var catchFishResult = player.catchFish(rainbowTrout);
  print(catchFishResult);

  // Player swims
  player.swim();

}


//Example of Then
// var farmWorkResult = await player.growCrop(strawberry)
//     .then((result) {
// print(result);
// });