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
    //**** [Ali] Top Widget - your application - hope page - grid structure
    return Scaffold(
        //****[Ali] appBar : top section

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue, //colors.red,
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
Widget _centerTest()
{
  return Center(
      child: Text('First name:',textScaleFactor: 3),
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
Widget _buildRowWidget()
{
  return Row(
    //mainAxisAlignment: MainAxisAlignment.center, //****[Ali] center aligned
    //mainAxisAlignment: MainAxisAlignment.end,  //****[Ali] right aligned
    //mainAxisAlignment: MainAxisAlignment.spaceEvenly, // //****[Ali] equal spacing
    //crossAxisAlignment: CrossAxisAlignment.start, //****[Ali] top side of row - inside the row

    //we use "children" array to define multiple sub-elements "containers"
    children: [
      //****[Ali] we use containers to orgonize the layout and the sub-elements of the widget
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

//****[Ali]****************************** Column - Flutter Logo - Wrapped in Container *****************************************
//****[Ali] Wrap "Column" in a container
Widget _buildColumnV2()
{
  return Container(
    //****[Ali] change the layout for the entire container
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FlutterLogo(
          size: 100,
          style: FlutterLogoStyle.stacked,
          textColor: Colors.red,
        ),
        FlutterLogo(
          size: 100,
          style: FlutterLogoStyle.horizontal,
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
        _buildStackWidget(),
        _buildStackWidget(),
        _buildStackWidget(),
        _buildStackWidget(),
        //_buildStackWidget(), //what happens?
      ],
    ),
  );
}

//****[Ali]****************************** Circular Avatar *****************************************
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

