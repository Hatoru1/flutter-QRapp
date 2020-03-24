import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';


class ScansBloc {
  
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }
  ScansBloc._internal(){
  //Obtener Scans de la base de datos
    obtenerScans();
  }

  final _scansStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansStreamController.stream;

  dispose(){
    _scansStreamController?.close();
  }

  obtenerScans() async {
    _scansStreamController.sink.add( await DBProvider.db.getTodosScans() );
  }

  agregarScan( ScanModel scan ) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {

    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTODOS() async {

    await DBProvider.db.deleteAll();
    obtenerScans();
  }


}