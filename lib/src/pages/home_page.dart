
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Reader'),
        actions: <Widget>[
          IconButton( 
            icon: Icon(Icons.delete_forever),
            onPressed:  scansBloc.borrarScanTODOS,  
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
      scansBloc.agregarScan(scan);

      // final scan2 = ScanModel( valor: 'geo:40.70549672661435,-74.00319471796878');
      // scansBloc.agregarScan(scan2);

      if( Platform.isIOS ){
        Future.delayed( Duration( milliseconds: 750 ),(){
          utils.abrirScan(scan);
        });
      }
      else{
          utils.abrirScan(scan);
      }
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