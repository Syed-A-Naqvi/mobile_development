import 'package:flutter/material.dart';
import 'grades_model.dart';
import 'grade.dart';
import 'grade_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradeFrequency {
  final String grade;
  final int frequency;

  GradeFrequency(this.grade, this.frequency);
}

class ListGrades extends StatefulWidget {
  final String title;
  const ListGrades({super.key, required this.title});

  @override
  State<ListGrades> createState() => _ListGradesState();
}

class _ListGradesState extends State<ListGrades> {
  final GradesModel _gradesModel = GradesModel(); // Database access
  List<Grade> grades = []; // Holds the grades to render
  bool selectionMode = false;
  Set<int> selectedItems = {}; // Track selected item IDs or indices

  @override
  void initState() {
    super.initState();
    _loadGrades(); // Load grades from the database when the page loads
  }

  Grade _randomGrade(){

    Random r = Random();
    String sid = '100${r.nextInt(1000000)}';
    int score = r.nextInt(101);
    String grade;

    if (score >= 90) {
      grade = 'A+';
    } else if (score >= 85) {
      grade = 'A';
    } else if (score >= 80) {
      grade = 'A-';
    } else if (score >= 77) {
      grade = 'B+';
    } else if (score >= 73) {
      grade = 'B';
    } else if (score >= 70) {
      grade = 'B-';
    } else if (score >= 67) {
      grade = 'C+';
    } else if (score >= 63) {
      grade = 'C';
    } else if (score >= 60) {
      grade = 'C-';
    } else if (score >= 57) {
      grade = 'D+';
    } else if (score >= 53) {
      grade = 'D';
    } else if (score >= 50) {
      grade = 'D-';
    } else {
      grade = 'F';
    }

    return Grade(sid: sid, grade: grade);

  }

  // Toggle selection mode
  void _toggleSelectionMode() {
    setState(() {
      selectionMode = !selectionMode;
      if (!selectionMode) selectedItems.clear(); // Clear selection if exiting mode
    });
  }
    // Toggle selection of a specific item
  void _toggleItemSelection(int id) {
    setState(() {
      if (selectedItems.contains(id)) {
        selectedItems.remove(id);
      } else {
        selectedItems.add(id);
      }
    });
  }

  void _loadGrades() async {
    grades = await _gradesModel.getAllGrades(); // Fetch grades from the database
    setState(() {
      if(selectionMode) _toggleSelectionMode();
    }); // Update UI with the loaded grades
  }

  // Add a new grade by navigating to GradeForm
  void _addGrade() async {
    final newGrade = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GradeForm()),
    );

    if (newGrade != null && newGrade is Grade) {
      await _gradesModel.insertGrade(newGrade);
      _loadGrades(); // Reload grades after adding
    }
  }

  void _deleteSelected() async {
    for (var id in selectedItems){
      await _gradesModel.deleteGradeById(id);
    }
    _loadGrades();
  }

  // Edit the selected grade by navigating to GradeForm with existing data
  void _editGrade(int gId) async {

    Grade? selectedGrade;

    for(int i = 0; i < grades.length; i++){
      if (grades[i].id == gId){
        selectedGrade = grades[i];
      }
    }

    if(selectedGrade != null){
      final editedGrade = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GradeForm(grade: selectedGrade),
        ),
      );
      if (editedGrade != null && editedGrade is Grade) {
        await _gradesModel.updateGrade(editedGrade);
        _loadGrades(); // Reload grades after editing
      }
    }

  }

  // Sorting function for different sorting types
  void _sortGrades(String sortType) {
    setState(() {
      switch (sortType) {
        case 'sid_asc':
          grades.sort((a, b) => a.sid.compareTo(b.sid));
          break;
        case 'sid_desc':
          grades.sort((a, b) => b.sid.compareTo(a.sid));
          break;
        case 'grade_asc':
          grades.sort((a, b) => a.grade.compareTo(b.grade));
          break;
        case 'grade_desc':
          grades.sort((a, b) => b.grade.compareTo(a.grade));
          break;
      }
    });
  }

  // Generate the frequency data for grades
  Map<String, int> _getGradeFrequency() {
    Map<String, int> frequency = {};
    for (var grade in grades) {
      frequency[grade.grade] = (frequency[grade.grade] ?? 0) + 1;
    }
    return frequency;
  }

  // Show the DataTable and Custom Bar Chart dialog
  void _showDataTable() {
  final frequencyData = Map.fromEntries(
    _getGradeFrequency().entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Grade Frequency Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // DataTable
            SizedBox(
              height: 290,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Grade')),
                    DataColumn(label: Text('Frequency')),
                  ],
                  rows: frequencyData.entries.map(
                    (entry) => DataRow(
                      cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text(entry.value.toString())),
                      ],
                    ),
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Bar Chart with Custom Width and Horizontal Scroll
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: frequencyData.length * 60.0, // Adjust width to fit all bars
                  child: CustomPaint(
                    size: Size(frequencyData.length * 60.0, 200), // Ensure canvas width is large enough
                    painter: BarChartPainter(frequencyData),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

  // Import grades from a CSV file
  Future<void> _importFromCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final input = file.openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter(eol: '\n'))
          .toList();

      List<Grade> newGrades = [];
      for (var row in fields.skip(1)) {
        if (row.length >= 2) {
          newGrades.add(Grade(sid: row[0].toString(), grade: row[1].toString()));
        }
      }

      // Insert each grade into the database
      for (var grade in newGrades) {
        await _gradesModel.insertGrade(grade);
      }

      // Reload grades to include newly added ones
      _loadGrades();
    }
  }

  // Function to export selected grades to a CSV file
  Future<void> _exportSelectedToCSV() async {
    // Filter out the selected grades
    final selectedGrades = grades.where((grade) => selectedItems.contains(grade.id!)).toList();

    // Prepare CSV data
    List<List<String>> csvData = [
      ['SID', 'Grade'], // CSV headers
      ...selectedGrades.map((grade) => [grade.sid, grade.grade])
    ];

    // Convert to CSV format
    String csv = const ListToCsvConverter(eol: '\n').convert(csvData);

    // Let the user choose the directory to save the file
    String? outputPath = await FilePicker.platform.getDirectoryPath();

    if (outputPath != null) {
      // Ask the user for the file name
      String? fileName = await _getFileNameFromUser();
      if (fileName != null && fileName.isNotEmpty) {
        final path = '$outputPath/$fileName.csv';

        // Write to the file
        final file = File(path);
        await file.writeAsString(csv);

        print('CSV file saved to $path');
      } else {
        print('No file name provided');
      }
    } else {
      print('No directory selected');
    }
  }

  // Function to get the file name from the user
  Future<String?> _getFileNameFromUser() async {
    TextEditingController fileNameController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter file name'),
          content: TextField(
            controller: fileNameController,
            decoration: const InputDecoration(hintText: 'File name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(fileNameController.text);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        toolbarHeight: 110, // Increase height to accommodate two rows
        title: SizedBox(
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end, // Align elements to the bottom
            children: [
              const Spacer(),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align icons to the right
                children: [
                    if (selectionMode) // Show delete button in selection mode
                    Row(
                      children: [
                      IconButton(
                        icon: Icon(
                        (selectedItems.length == grades.length) ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                        if (selectedItems.length == grades.length) {
                          selectedItems.clear();
                        } else {
                          for (var grade in grades) {
                          if (!selectedItems.contains(grade.id!)) {
                            selectedItems.add(grade.id!);
                          }
                          }
                        }
                        setState(() {});
                        },
                      ),
                      Text(
                        'Select All',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15),
                      ),
                      ],
                    ),
                    const Spacer(), // Takes up all available space between the buttons
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.dice),
                      padding: const EdgeInsets.only(right: 20),
                      onPressed: () {
                        for(int i = 0; i <= 10; i++){
                          _gradesModel.insertGrade(_randomGrade());
                        }
                        _loadGrades();
                      },
                    ),
                    IconButton(
                    icon: const Icon(Icons.file_download_rounded),
                    onPressed: _importFromCSV,
                    ),
                  IconButton(
                    icon: const Icon(Icons.bar_chart),
                    onPressed: _showDataTable,
                  ),
                  IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () async {
                      final selectedSort = await showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(1, kToolbarHeight, 0, 0),
                        color: Theme.of(context).colorScheme.primary,
                        items: [
                          PopupMenuItem(
                            value: 'sid_asc',
                            child: Text(
                              'SID Ascending',
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'sid_desc',
                            child: Text(
                              'SID Descending',
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'grade_asc',
                            child: Text(
                              'Grade Ascending',
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'grade_desc',
                            child: Text(
                              'Grade Descending',
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ],
                      );
                      if (selectedSort != null) {
                        _sortGrades(selectedSort);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.783 - kToolbarHeight,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 1,
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: grades.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(grades[index].id), // Unique key for each item
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      await _gradesModel.deleteGradeById(grades[index].id!);
                      _loadGrades(); // Reload the list after deletion
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    backgroundColor: const Color.fromARGB(255, 154, 5, 5),
                  ),
                ],
              ),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          grades[index].sid,
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        subtitle: Text(
                          grades[index].grade,
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        onLongPress: () {
                          _toggleSelectionMode();
                        },
                        onTap: () {
                          if (selectionMode) {
                            _toggleSelectionMode();
                          } 
                        },
                      ),
                    ),
                    if (selectionMode) // Show select button in selection mode
                      IconButton(
                        icon: Icon(
                          (selectedItems.contains(grades[index].id)) ? Icons.check_box : Icons.check_box_outline_blank,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed:() {
                          _toggleItemSelection(grades[index].id!);
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        children: [
          // Main Floating Action Button
          if(!selectionMode)
            Align(
              alignment: const Alignment(0.98, 1.01),
              child: FloatingActionButton(
                onPressed: _addGrade,
                heroTag: 'addGrade',
                child: const Icon(Icons.add),
              ),
            ),
          // Conditionally display a second Floating Action Button
          if(selectedItems.isNotEmpty)
            Align(
              alignment: const Alignment(-0.80, 1.01),
              child: FloatingActionButton(
                onPressed: _deleteSelected,
                heroTag: 'deleteGrades',
                backgroundColor: const Color.fromARGB(255, 154, 5, 5),
                child: const Icon(Icons.delete),
              ),
            ),
          if(selectedItems.isNotEmpty)
            Align(
              alignment: const Alignment(0.55, 1.01),
              child: FloatingActionButton(
                onPressed: _exportSelectedToCSV,
                heroTag: 'exportGrades',
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.upload_file_rounded),
              ),
            ),
          if(selectedItems.length == 1)
            Align(
              alignment: const Alignment(0.98, 1.01), // Place the button in a different position
              child: FloatingActionButton(
                onPressed: (){_editGrade(selectedItems.first);},
                heroTag: 'editGrade',
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: const Icon(Icons.edit),
              ),
            ),
          // Conditionally display a third Floating Action Button
        ],
      ),
    );
  }
}

// CustomPainter for bar chart with grid and axes
class BarChartPainter extends CustomPainter {
  final Map<String, int> data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    // Configurations
    const double leftPadding = 40; // Padding for y-axis labels
    const double topPadding = 10; // Padding for the top label
    final plotWidth = size.width - leftPadding;
    final barWidth = plotWidth / (data.length * 2);
    final maxFrequency = data.values.isNotEmpty ? data.values.reduce((a, b) => a > b ? a : b) : 1;

    // Paints
    final barPaint = Paint()..color = Colors.blue;
    final axisPaint = Paint()..color = Colors.white..strokeWidth = 2;
    final gridPaint = Paint()..color = Colors.grey..strokeWidth = 1;

    // Adjusted plot height to leave space for x-axis labels
    final plotHeight = size.height * 0.8 - topPadding;

    // Draw y-axis grid lines and labels
    _drawYAxis(canvas, leftPadding, topPadding, plotWidth, plotHeight, maxFrequency, gridPaint);

    // Draw bars with x-axis labels
    _drawBarsWithLabels(canvas, leftPadding, topPadding, barWidth, plotHeight, maxFrequency, barPaint);

    // Draw x and y axes
    _drawAxes(canvas, leftPadding, topPadding, plotWidth, plotHeight, axisPaint);
  }

  // Draws y-axis grid lines and labels at intervals
  void _drawYAxis(Canvas canvas, double leftPadding, double topPadding, double plotWidth, double plotHeight, int maxFrequency, Paint gridPaint) {
    for (int i = 0; i <= 5; i++) {
      final y = topPadding + plotHeight - (i / 5) * plotHeight;
      canvas.drawLine(Offset(leftPadding, y), Offset(leftPadding + plotWidth, y), gridPaint);

      // Draw y-axis labels
      TextPainter(
        text: TextSpan(
          text: (maxFrequency * i / 5).toStringAsFixed(0),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: 30)
        ..paint(canvas, Offset(leftPadding - 35, y - 6)); // Position labels to the left of plot area
    }
  }

  // Draws each bar and its corresponding x-axis label
  void _drawBarsWithLabels(Canvas canvas, double leftPadding, double topPadding, double barWidth, double plotHeight, int maxFrequency, Paint paint) {
    data.entries.toList().asMap().forEach((index, entry) {
      final left = leftPadding + index * 2 * barWidth + barWidth / 2;
      final top = topPadding + plotHeight - (entry.value / maxFrequency) * plotHeight;

      // Draw the bar
      canvas.drawRect(Rect.fromLTWH(left, top, barWidth, plotHeight - top + topPadding), paint);

      // Draw x-axis label below the bar
      TextPainter(
        text: TextSpan(text: entry.key, style: const TextStyle(color: Colors.white, fontSize: 12)),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: barWidth, maxWidth: barWidth)
        ..paint(canvas, Offset(left, plotHeight + topPadding + 5));
    });
  }

  // Draws the x and y axes
  void _drawAxes(Canvas canvas, double leftPadding, double topPadding, double plotWidth, double plotHeight, Paint axisPaint) {
    // X-axis
    canvas.drawLine(Offset(leftPadding, topPadding + plotHeight), Offset(leftPadding + plotWidth, topPadding + plotHeight), axisPaint);
    // Y-axis
    canvas.drawLine(Offset(leftPadding, topPadding), Offset(leftPadding, topPadding + plotHeight), axisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


