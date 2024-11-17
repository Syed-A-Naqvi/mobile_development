import 'package:flutter/material.dart';
import 'post.dart';

class PostData extends StatefulWidget {
  
  final List<Post> data;

  const PostData({super.key, required this.data});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {

  late List<Post> data;
  int? _sortedColumn;
  bool _isAscending = false;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  void didUpdateWidget(PostData oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      data = widget.data;
    }
  }

  void _sort(Function(Post post) getField, int columnIndex){
    _sortedColumn = columnIndex;
    data.sort((a, b) {
      final aVal = getField(a);
      final bVal = getField(b);
      return (_isAscending) ? aVal.compareTo(bVal) : bVal.compareTo(aVal);
    },);
    _isAscending = !_isAscending;
    setState(() {});
  }

  List<DataColumn> _createColumns(){
    return [
      DataColumn(
        label: Row(
          children: [
            const Text('Title', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            Icon(( (_sortedColumn ?? -1) != 0) ? Icons.remove : (_isAscending) ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ],
        ),
        onSort: (columnIndex, _ ) {
          _sort((post) => post.title, columnIndex);
        }
      ),
      DataColumn(
        label: Icon(( (_sortedColumn ?? -1) != 1) ? Icons.remove : (_isAscending) ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        onSort: (columnIndex, _ ) {
          _sort((post) => post.numUpVotes, columnIndex);
        }
      ),
      DataColumn(
        label: Icon(( (_sortedColumn ?? -1) != 2) ? Icons.remove : (_isAscending) ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        onSort: (columnIndex, _ ) {
          _sort((post) => post.numDownVotes, columnIndex);
        }
      ),
    ];
  }

  List<DataRow> _createRows(){
    return this.data.map((post) {
      return DataRow(
        cells: [
          DataCell(Text(post.title)),
          DataCell(
            Row(
              children: [
                Text(post.numUpVotes.toString()),
                const Icon(Icons.arrow_upward)
              ],
            )
          ),
          DataCell(
            Row(
              children: [
                Text(post.numDownVotes.toString()),
                const Icon(Icons.arrow_downward)
              ],
            )
          ),
        ]
      );
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: _createColumns(),
        rows: _createRows()
      ),
    );  
  }

}