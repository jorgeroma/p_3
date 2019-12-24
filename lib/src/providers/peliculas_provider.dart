
import 'dart:async';
import 'dart:convert';

import 'package:p_3/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http; 

class PeliculasProvider{

  String _apiKey    = '1651ca6f8965f0309c6a9ebd324b5b47';
  String _url       = 'api.themoviedb.org';
  String _languaje  = 'es-ES';

  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>)get popularesSink => _popularesStreamController.sink.add;
  
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }



  Future<List<Pelicula>>getEnCines() async{

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _languaje
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>>getPopulares() async{

    _popularesPage++;

    final url = Uri.http(_url, '3/movie/popular',{
      'api_key'  : _apiKey,
      'language' :_languaje,
      'page'     :_popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;

  }



}