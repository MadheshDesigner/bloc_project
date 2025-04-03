import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  const ItemDetailScreen({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text("Item Details"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
            SizedBox(height: 20,),
            Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Text(description,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
