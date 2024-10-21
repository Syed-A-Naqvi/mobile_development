// ----------------------------------- Classes, Inheritence, Abstract Classes and Mixins -----------------------------------

// this is a concrete class
// it is meant to be inherited from by other classes
class Device {
  String? _manufacturer;
  static int _count = 0;

  Device({String manufacturer = 'Unknown'})
  {
    _count++;
    this._manufacturer = manufacturer;
  }
}

// mixins are used to insert standalone method implementations directly into classes
mixin PhoneFunctionalities {
  
  void call(int id2)
  {
    print('calling phone with ID: ${id2}');
  }

  void message(int id2, String msg)
  {
    print("sending message to phone ID: ${id2}");
    print("${msg}");
  }

}

// an abstract class provides an incomplete blueprint of class functionality meant to be inherited from
  // 'extending' an abstract class inherits all fields, methods (constructor included) and prototype implementation contracts
  // 'implementing' an abstract class ignores everything except methods which are inherited as contractual implementation requirements
  // 'implements' basically turns abstract classes into interfaces
abstract class SmartPhone{
  
  void installApp(String app);
  void uninstallApp(String app);
}

class Phone extends Device with PhoneFunctionalities implements SmartPhone {
  String? _model;
  int _id = 0;

  Phone({String manufacturer = 'Unknwon', String model = 'Unknown', bool face_id = false}) : super(manufacturer: manufacturer)
  {
    this._id = Device._count;
    this._model = model;
  }

  void installApp(String appname){
    print('installing ${appname} on device ID: ${this._id}...');
  }
  void uninstallApp(String appname){
    print('uninstalling ${appname} from device ID: ${this._id}...');
  }

  int getid(){return this._id;}
  
  @override
  String toString(){
    return "This is a ${this._manufacturer} ${this._model} with ID: ${this._id}.";
  }

}

// ----------------------------------- Classes, Inheritence, Abstract Classes and Mixins -----------------------------------


// ----------------------------------- Asynch -----------------------------------

// a Future<type> is a promise to complete an operation and is like a placeholder for a future value
Future<String> doSomethingLater() async
{
  print('Operation started.');
  // the await keyword can only be used in an async function
  // this keyword will pause the current async function (but not block the entire program) execution until a future promise is fullfilled
  await Future.delayed(Duration(seconds: 3));
  print('Operation completed.');
  return "This is some information compiled during the operation.";
}

// ----------------------------------- Asynch -----------------------------------


void main(List<String> args) {
  
  Phone phone1 = Phone(model: "pixel 3XL", manufacturer: "Google");

  print(phone1);
  phone1.call(10);
  phone1.message(10, "Hello how are you hi bye.");
  phone1.installApp("tikok");
  phone1.uninstallApp("tikok");

  Future<String> result = doSomethingLater();
  result.then((data) => print(data));

}