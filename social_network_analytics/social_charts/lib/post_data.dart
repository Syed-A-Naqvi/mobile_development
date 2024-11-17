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
  bool _isAsc = true;

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

  List<DataColumn> _createColumns(){
    return [
      const DataColumn(
        label: Text('Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ),
      const DataColumn(
        label: Icon(Icons.arrow_drop_up)
      ),
      const DataColumn(
        label: Icon(Icons.arrow_drop_up)
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
                const Icon(Icons.arrow_upward)],
            )
          ),
          DataCell(
            Row(
              children: [
                Text(post.numDownVotes.toString()),
                const Icon(Icons.arrow_downward)],
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