import 'package:flutter/material.dart';
import 'package:p_3/src/providers/peliculas_provider.dart';
import 'package:p_3/src/search/search_delegate.dart';
import 'package:p_3/src/widgets/card_swiper_wiget.dart';
import 'package:p_3/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    
    peliculasProvider.getPopulares();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en el cine'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
      
    );
  }

  Widget _swiperTarjetas() {

    

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data,);
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

      },
    );
  }
  
  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,),
            padding: EdgeInsets.only(left: 12.0),
          ),
          SizedBox(height: 15.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){

              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,  
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

}