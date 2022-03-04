import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false ,
      theme: ThemeData(brightness: Brightness.dark, 
      primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];

  final String apikey = 'e3a3b3325015c70541b45872274e963e';
  final readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlM2EzYjMzMjUwMTVjNzA1NDFiNDU4NzIyNzRlOTYzZSIsInN1YiI6IjYyMTcyZjJjOGQyZjhkMDAxYmY3YWE3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yAAFhvl3NfzJ2Ev_zNWf0lHWWdc_rDa_WSeqBCXM87k';


  
  @override
  void initState(){
    loadmovies();
    super.initState();
  }


  loadmovies()async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ));
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();

    
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
    });
    print(trendingmovies);
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: modified_text(text: "Movie App 🎥",color: Colors.white,size: 16 ),),
        body:ListView(
          children:[
          TrendingMovies(trending: trendingmovies),
          TopRated(toprated: topratedmovies),
          ],
        ),
    );
  }
}