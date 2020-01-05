import 'package:flutter/material.dart';
import 'package:p_3/src/models/pelicula_model.dart';
import 'package:p_3/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion ='';

  final peliculaProvider = new PeliculasProvider();

  // final peliculas = [
  //   'spiderman',
  //   'ad astra',
  //   'batman',
  //   'avengers',
  //   'star wars',
  //   'lego',
  //   'iron man'
  // ];

  // final peliculasRecientes = [
  //   'avengers',
  //   'star wars',
  // ];


  @override
   ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del Appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';          
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        // height: 100.0,
        // width: 100.0,
        // color: Colors.blueAccent,
        // child: Text(seleccion),
      ),
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Sugerencias que aparecen al escribir

  //   final listaSugerida = (query.isEmpty) 
  //                           ? peliculasRecientes 
  //                           : peliculas.where(
  //                               (p)=> p.toLowerCase().startsWith(query.toLowerCase())
  //                           ).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion=listaSugerida[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }


  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al escribir

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculaProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );


  }




}