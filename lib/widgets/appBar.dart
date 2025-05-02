import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class APpBar{
  TextStyle styleTitulo = GoogleFonts.merriweather(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white);
  TextStyle styleDetalle = GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600,color:const Color.fromARGB(255, 102, 102, 102));

  AppBar GetAppBarHome(title,automaticallyImplyLeading,context,scaffoldKey,){
    return AppBar(

      title: Text("$title" ,style:styleTitulo ),
      leading: IconButton(
      icon: Icon(size: 30,Icons.menu, color:  Colors.white ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      titleSpacing: 50.0,
      centerTitle: true,
      toolbarHeight: 60.2,
      toolbarOpacity: 0.8,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(
        color: Colors.transparent 
      ),
      /* shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10)),
      ),*/
      elevation: 0.00,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    
    );
  }


    AppBar GetAppBar(title,automaticallyImplyLeading,context){
    return AppBar(
      title: Text("$title" ,style:   Theme.of(context).textTheme.displayLarge),
      leading: IconButton(
      icon: Icon(Icons.arrow_back_outlined, color: const Color.fromARGB(255, 248, 248, 248)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 50.0,
      centerTitle: true,
      toolbarHeight: 60.2,
      toolbarOpacity: 0.8,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(
        color: Colors.white, 
      ),
     /* shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10)),
      ),*/
      elevation: 0.00,
      shadowColor: Colors.black,
      backgroundColor: const Color.fromARGB(255, 174, 215, 248),
    
    );
  }

     AppBar GetAppBar2(title,automaticallyImplyLeading,context){
      return AppBar(
        title:  Text("$title" ,style:   Theme.of(context).textTheme.displayLarge),
        leading: Icon(Icons.close),
        titleSpacing: 50.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        iconTheme: IconThemeData(
        color: Color.fromARGB(255, 252, 252, 252), 
      ),
   actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {

              Navigator.pop(context);
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
              bottomLeft: Radius.circular(0)),
        ),
      elevation: 0.00,
      shadowColor: Colors.black,
      backgroundColor: const Color.fromARGB(255, 174, 215, 248),
      );

  }


  
}