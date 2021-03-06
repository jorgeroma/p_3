import 'package:flutter/material.dart';
import 'package:p_3/src/pages/home_page.dart';
import 'package:p_3/src/pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/'       : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}