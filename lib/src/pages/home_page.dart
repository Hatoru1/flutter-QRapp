import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'direcciones_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Reader'),
        actions: <Widget>[
          IconButton( 
            icon: Icon(Icons.delete_forever),
            onPressed: (){
            },  
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_strong),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR()async{

    // https://fernando-herrera.com
    // geo:40.70549672661435,-74.00319471796878

    // String futureString = ''; 
    String futureString = 'https://fernando-herrera.com'; 
    // try{
    //   futureString = await new QRCodeReader().scan();
    // }
    // catch(e){
    //   futureString = e.toString();
    // }

    if( futureString !=null ){

      final scan = ScanModel( valor: futureString);
      DBProvider.db.nuevoScan(scan);
      
    }

  }

  Widget _callPage(int paginaActual){
    
    switch( paginaActual ){
      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default:
      return MapasPage(); 
    }
  }

  Widget _crearBottomNavigationBar(){

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex= index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        ),
      ],
    );
  }
}