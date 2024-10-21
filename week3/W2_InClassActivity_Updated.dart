import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //**** [Ali] Top Widget - your application - home page - grid structure
    return Scaffold(
      //****[Ali] appBar : top section
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary, //colors.red,
          title: Text(widget.title),
        ),
        //****[Ali] body : you can add your widget here - Similar to calling functions
        body: _buildAvatarV2() //****[Ali] call your widgets here **************************************************
    );
  }
}


//****[Ali] ********************************* WIDGETS
//****[Ali] *****************************************
//****[Ali] *****************************************




//****[Ali] use Widget keyword to define a Widget - use predefined elements (e.g., row, column,...)
//****[Ali] or you can simply return UI elements (text)
Widget _SimplecenterTest()
{
  return Text('First name:',textScaleFactor: 3);
}

Widget _centerTest()
{
  return Center(
    child: Text('First name:',textScaleFactor: 3),
  );
}



//****[Ali] use style to modify text
Widget _centerTestV2() {
  return Center(
    child: Text(
      'First name:',
      style: TextStyle(
        fontSize: 30, // Set your desired font size here
      ),
    ),
  );
}

//****[Ali] use style to modify text --- advanced
Widget _centerTestV3() {
  return Center(
    child: Text(
      'First name:',
      style: TextStyle(
        fontSize: 30,            // Font size
        fontWeight: FontWeight.bold,  // Bold text
        color: Colors.blue,      // Text color
        letterSpacing: 2.0,      // Adds space between letters
        decoration: TextDecoration.underline,  // Underlines the text
        decorationStyle: TextDecorationStyle.dashed, // Dashed underline
      ),
    ),
  );
}

Widget _alignTest()
{
  return Align(
    //****[Ali] when you want to allign specific UI element
    alignment: Alignment.topRight,
    child: Text('First name:',textScaleFactor: 3),
  );
}

//****[Ali] In Flutter (and generally in 2D graphics in Dart), the coordinate (0, 0) ----
// refers to the top-left corner of the screen or the container in which the widget is placed.
Widget _positionTest()
{
  return Positioned(
    top: 50.0,
    left: 20.0,
    child: Text('First name:',textScaleFactor: 3),
  );
}


//****[Ali]****************************** Basic Row *****************************************
//****[Ali] use Widget keyword to define a Widget - use predefined elements (e.g., row, column,...)

// ****[Ali]The Row widget is used to arrange child widgets horizontally.
// Each child will be placed next to each other in a line.
Widget _buildRowWidget()
{
  return Row(
    //***[Ali]This property defines how the child widgets are distributed horizontally within the row.
    //mainAxisAlignment: MainAxisAlignment.center, //****[Ali] center aligned
    //mainAxisAlignment: MainAxisAlignment.end,  //****[Ali] right aligned
    //mainAxisAlignment: MainAxisAlignment.spaceEvenly, // //****[Ali] equal spacing
    crossAxisAlignment: CrossAxisAlignment.start, //****[Ali] top side of row - inside the row

    //***[Ali] we use "children" array to define multiple sub-elements "containers"
    //***[Ali]The Row widget contains a children property, which takes a list of widgets. --
    // In this case, it contains three Container widgets. --
    // These containers are placed horizontally next to each other inside the Row.
    children: [
      //****[Ali] we use containers to orgonize the layout and the sub-elements of the widget
      //***[Ali] hover mouse on container to see possible attributes
      Container(
        width: 80,
        height: 20, //if we remove this?
        color: Colors.red,
      ),
      Container(
        width: 90,
        height: 50,
        color: Colors.blue,
      ),
      Container(
        width: 80,
        height: 50,
        color: Colors.green,
      ),
    ],
  );
}

//****[Ali]****************************** Basic Column / Flutter Logo *****************************************
//****[Ali] similar to row
Widget _buildColumn()
{
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      FlutterLogo(
        size: 100,
        style: FlutterLogoStyle.stacked, //Logo on top of text
        textColor: Colors.red,
      ),
      FlutterLogo(
        size: 100,
        style: FlutterLogoStyle.horizontal, //in a row
        textColor: Colors.black,
      ),
      FlutterLogo(
        size: 100,
        textColor: Colors.blue, //just a logo by default
      ),
    ],
  );
}


//****[Ali]****************************** Column - Flutter Logo - Column Wrapped in Container *****************************************
//another way to orgonize column using container
//****[Ali] Wrap "Column" in a container
Widget _buildColumnV2()
{
  return Container(
    //****[Ali] change the layout for the entire container
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end, //what does this mean?
      children: [
        //***[Ali]FlutterLogo is a widget that displays the Flutter logo. ---
        //It's often used as a placeholder or for decorative purposes in Flutter apps.
        FlutterLogo(
          size: 100,
          //***[Ali] horizontal: The logo and the text are arranged horizontally, side by side.
          style: FlutterLogoStyle.horizontal,
          textColor: Colors.red,
        ),
        FlutterLogo(
          size: 100,
          //***[Ali] stacked: The logo is stacked with the Flutter text placed below it.
          style: FlutterLogoStyle.stacked,
          textColor: Colors.black,
        ),
        FlutterLogo(
          size: 100,
          textColor: Colors.blue,
        ),
      ],
    ),
  );
}

//****[Ali]****************************** Stack Widget - Basic *****************************************
//****[Ali] 3 squares - top left corner
Widget _buildStackWidget()
{
  return Stack(
    //****[Ali] all elements ore aligned to the center of "Stack" not display
    alignment: Alignment.center,
    children: [
      Container(
        width:200,
        height: 200,
        color: Colors.red,
      ),
      Container(
        width:100,
        height: 100,
        color: Colors.green,
      ),
      Container(
        width:50,
        height: 50,
        color: Colors.blue,
      )
    ],
  );
}
//the size and order important?
//how to put in the center of display?


//****[Ali]****************************** Widget Combination - Column/Stack *****************************************
Widget _buildColumnStacked()
{
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //you can use different widgets - list of widgets
        _buildStackWidget(),
        _buildStackWidget(),
        _buildStackWidget(),
        _buildStackWidget(),
        //_buildStackWidget(), //what happens?
      ],
    ),
  );
}

//****[Ali]****************************** Widget Combination - Column/Stack *****************************************
//****[Ali] previous example with no container - use container to arrange the layout
Widget _buildColumnStackedNoContainer()
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      //you can use different widgets - list of widgets
      _buildStackWidget(),
      _buildStackWidget(),
      _buildStackWidget(),
      _buildStackWidget(),
      //_buildStackWidget(), //what happens?
    ],
  );

}

//****[Ali]****************************** Circular Avatar with Text *****************************************
Widget _buildAvatar()
{
  return Stack(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.red,
        child: Text("Ali", textScaleFactor: 3),
      ),
    ],
  );
}


//****[Ali]****************************** Circular Avatar with Text IN A BOX*****************************************
//apply container to Child: Text .....
Widget _buildAvatarV2()
{
  return Stack(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.red,
        child: Container(
          //****[Ali] modify the look of container
          //****[Ali] This can be done without decoration - check Row Widget
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("Ali", textScaleFactor: 3)),
      ),
    ],
  );
}


