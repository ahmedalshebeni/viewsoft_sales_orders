// import 'package:flutter/material.dart';
//
// import 'BasicData.dart';
//
// class ListItem extends StatefulWidget {
//   ListItem(this.payloaditem,this.payloaduid,this.index);
//  Payload payloaditem;
//  Payload payloaduid;
//  int indexx =0;
//
//   @override
//   _ListItemState createState() => _ListItemState();
// }
//
// class _ListItemState extends State<ListItem> {
//   TextEditingController txt1 =TextEditingController();
//
//   TextEditingController txt2 =TextEditingController();
//
//   TextEditingController txt3 =TextEditingController();
//
//  dynamic  item ;
//
//   Map rowform=  { 1 : {"الصنف": "", "الوحده": "", "text1": "", "text2": "", "text3": ""}  };
//
//   final _FormKey =  GlobalKey<FormState>();
//   @override
//   void initState() {
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
// rowform[1]["الصنف"];
//     return Form(
//       key:  _FormKey,
//       child: Row(children: [
//         DropdownButtonFormField(items:widget.payloaditem.map<DropdownMenuItem<dynamic>>((value) {
//                               return DropdownMenuItem<dynamic>(
//                                   value:  value,
//                                   child:Text(' ${value.item_name}',
//                                       overflow: TextOverflow.visible));
//                             }).toList(),hint: Text("الصنف"),selectedItemBuilder: (value){
//           item = value;
//         },value: item,
//           onSaved: (value) {
//             rowform["الصنف"] = value;
//             print(rowform);
//             },),
//         DropdownButtonFormField(items:widget.payloaduid.map<DropdownMenuItem<dynamic>>((value) {
//           return DropdownMenuItem<dynamic>(
//               value:  value,
//               child:Text(' ${value.item_name}',
//                   overflow: TextOverflow.visible));
//         }).toList()
//
//
//           ,hint: Text("الوحدة"),selectedItemBuilder: (value){
//           item = value;
//         },value: item,
//           onSaved: (value) {
//           rowform["الوحده"] = value;
//           print(rowform);
//         },
//         ),
//         TextFormField(
//           controller: txt1,
//           onSaved: (value) {
//             rowform["text1"] = value;
//             print(rowform);
//           },
//         ),
//         TextFormField(
//           controller: txt2,
//           onSaved: (value) {
//             rowform["text2"] = value;
//             print(rowform);
//           },
//         ),
//         TextFormField(
//           controller: txt3,
//           onSaved: (value) {
//             rowform["text3"] = value;
//             print(rowform);
//           },
//         ),
//
//       ],),
//     );
//   }
// }
