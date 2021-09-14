import 'package:flutter/material.dart';
import 'package:viewsoft_hr/Gui/edited/model.dart';

class DetailWidget extends StatefulWidget {
final List<Item> items;
final List<ItemUnit> itemUnites;
TextEditingController expiryController;
TextEditingController quntityController;
TextEditingController priceController;
Item selectedItem;
ItemUnit selectedItemUnit;

DetailWidget(this.items, this.itemUnites, this.expiryController, this.quntityController, this.priceController, this.selectedItem, this.selectedItemUnit);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
              children:<Widget>[
                Container(
                  width: 200,
                  child: DropdownButton<Item>(
                    hint: Text('الصنف'),
                    value: widget.selectedItem ,
                    isExpanded: true,
                    icon: Icon(Icons.check_circle_outline),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.blue[300],
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        widget.selectedItem = newValue;
                        print(widget.selectedItem.itemId);
                      });
                    },
                    items: widget.items
                        .map<DropdownMenuItem<Item>>((value) {
                      return DropdownMenuItem<Item>(
                          value:  value,
                          child:Text(' ${value.itemName}',
                              overflow: TextOverflow.visible));
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width:200,
                  child:
                  DropdownButton<ItemUnit>(
                    hint: Text('الوحدة'),
                    value: widget.selectedItemUnit,
                    isExpanded: true,
                    icon: Icon(Icons.check_circle_outline),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.blue[300],
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        widget.selectedItemUnit  = newValue;
                        print(widget.selectedItemUnit.uId);
                      });
                    },
                    items: widget.itemUnites
                        .map<DropdownMenuItem<ItemUnit>>((value) {
                      return DropdownMenuItem<ItemUnit>(
                          value:  value,
                          child:Text(' ${value.uName}'));
                    }).toList(),
                  ),
                ),
                field('ت:الصلاحية', Icons.calendar_today, widget.expiryController,TextInputType.text),
                field('الكمية', Icons.photo_album_sharp, widget.quntityController,TextInputType.number),
                field('السعر', Icons.attach_money, widget.priceController,TextInputType.number),
              ]

          ),
        ],
      ),
    );
  }
 Container field(String label, IconData icon, TextEditingController controller, TextInputType inputType ) {
   return Container(
     width: 150,
     child: TextField(
       style: TextStyle(fontSize: 15.0, color: Colors.deepPurple),
       decoration: InputDecoration(
         border: UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.grey, width: 0.5)
         ),
         focusedBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.grey, width: 0.5)
         ),
         enabledBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.grey, width: 0.5)
         ),
         hintText: '$label',
         prefixIcon: Icon(
          icon,
          color: Colors.deepPurple,
          size: 20.0,
        ),
       ),
       controller: controller,
       keyboardType: inputType,
       // TextInputType.number,
     ),
   );
 }
}