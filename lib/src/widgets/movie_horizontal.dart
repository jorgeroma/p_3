import 'package:flutter/material.dart';

import '../models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );


  @override
  Widget build(BuildContext context) {
    
    final _screensize = MediaQuery.of(context).size;

    _pageController.addListener((){

      if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
        siguientePagina();
      }

    });
    
    return Container(
      height: _screensize.height*0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context,i)=> _tarjeta(context, peliculas[i]),
      ),

      
    );
  }


  Widget _tarjeta(BuildContext context, Pelicula pelicula){
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(pelicula.title,
              overflow:TextOverflow.ellipsis, 
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );


    return GestureDetector(
      child: tarjeta,
      onTap: (){

        Navigator.pushNamed(context, 'detalle', arguments: pelicula);

      },
      
    );
  }


  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(pelicula.title,
              overflow:TextOverflow.ellipsis, 
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}