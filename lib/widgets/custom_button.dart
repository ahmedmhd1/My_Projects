import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
   CustomButton({required this.onTap,required this.title});
String title;
VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return      GestureDetector(
      onTap:onTap ,
      child: Container(
                decoration: BoxDecoration(
                color: Colors.white,
    borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                height: 60,
                child: Center(child: Text(title,style: TextStyle(fontSize: 20,color: Colors.black ))),),
    );
  }
}