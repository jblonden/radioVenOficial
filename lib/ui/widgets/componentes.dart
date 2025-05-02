import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
class Componentes{



  
  void  showAlertDialog(title,desc,dialogType,context) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType, 
      animType: AnimType.bottomSlide,
      btnOkColor: Color.fromARGB(255, 3, 95, 209),
      title: title,
      desc: desc,
    // btnCancelOnPress: () {},
      btnOkOnPress: () {
        ///Navigator.pop(context);
      },
    ).show();
}
  void  showAlertDialog2(title,desc,dialogType,context) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType, 
      animType: AnimType.bottomSlide,
      btnOkColor: Color.fromARGB(255, 3, 95, 209),
      title: title,
      desc: desc,
    // btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
}

  void  showAlertDialog3(title,desc,dialogType,context) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType, 
      animType: AnimType.bottomSlide,
      btnCancelColor: Color.fromARGB(255, 255, 8, 0),
      btnOkColor: Color.fromARGB(255, 3, 95, 209),
      title: title,
      desc: desc,
    // btnCancelOnPress: () {},
      btnOkOnPress: () {


      },

      btnCancelOnPress: () {
      
      },
    ).show();
}

 OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
    return OutlineInputBorder( //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
          color:Color.fromARGB(255, 103, 194, 243),
          width: 1,
        )
    );
  }

  OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
          color:Color.fromARGB(255, 197, 71, 4),
          width: 1,
        )
    );
  }
}