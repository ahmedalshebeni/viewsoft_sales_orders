//DataTable
import 'package:flutter/material.dart';

void main() {runApp(MyApp());}

class MyApp extends StatefulWidget {
  @override
  _DataTableExample createState() => _DataTableExample();
}

class _DataTableExample extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter DataTable Example'),
          ),
          body: ListView(children: <Widget>[
            Center(
                child: Text(
                  'People-Chart',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            DataTable(
              columns: [
                DataColumn(
               label:
                Text(
                    'ID',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )
                ),
                DataColumn(label: Text(
                    'Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Profession',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Stephen')),
                  DataCell(Text('Actor')),
                ]),
                DataRow(cells: [
                  DataCell(Text('5')),
                  DataCell(Text('John')),
                  DataCell(Text('Student')),
                ]),
                DataRow(cells: [
                  DataCell(Text('10')),
                  DataCell(Text('Harry')),
                  DataCell(Text('Leader')),
                ]),
                DataRow(cells: [
                  DataCell(Text('15')),
                  DataCell(Text('Peter')),
                  DataCell(Text('Scientist')),
                ]),
              ],
            ),
          ])
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// void main() {runApp(MyApp());}
//
// class MyApp extends StatefulWidget {
//   @override
//   _TableExample createState() => _TableExample();
// }
//
// class _TableExample extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Flutter Table Example'),
//           ),
//           body: Center(
//               child: Column(children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(20),
//                   child: Table(
//                     defaultColumnWidth: FixedColumnWidth(120.0),
//                     border: TableBorder.all(
//                         color: Colors.black,
//                         style: BorderStyle.solid,
//                         width: 2),
//                     children: [
//                       TableRow( children: [
//                         Column(children:[Text('Website', style: TextStyle(fontSize: 20.0))]),
//                         Column(children:[Text('Tutorial', style: TextStyle(fontSize: 20.0))]),
//                         Column(children:[Text('Review', style: TextStyle(fontSize: 20.0))]),
//                       ]),
//                       TableRow( children: [
//                         Column(children:[Text('Javatpoint')]),
//                         Column(children:[Text('Flutter')]),
//                         Column(children:[Text('5*')]),
//                       ]),
//                       TableRow( children: [
//                         Column(children:[Text('Javatpoint')]),
//                         Column(children:[Text('MySQL')]),
//                         Column(children:[Text('5*')]),
//                       ]),
//                       TableRow( children: [
//                         Column(children:[Text('Javatpoint')]),
//                         Column(children:[Text('ReactJS')]),
//                         Column(children:[Text('5*')]),
//                       ]),
//                     ],
//                   ),
//                 ),
//               ])
//           )),
//     );
//   }
// }