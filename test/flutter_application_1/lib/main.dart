import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'music.dart';
import 'dart:async';




void main() {
  runApp(const MyApp());
}

List<Music> myMusicList = [
  Music('Je vis je visser', 'PNL', 'assets/pnl-que-la-famille.jpg', 'music/pnl-qlf-je-vis-je-visser.mp3'),
  Music('Lala', 'PNL', 'assets/pnl-que-la-famille.jpg', 'music/lala.mp3'),
];

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QLFify',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: const MyHomePage(title: 'QLFify'),
    );
  }
  
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentSliderValue = 0;
  int range = 0;
  bool isPlaying = true;
  

  final _player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void play() {
    if (isPlaying == true){
      _player.play();
    }else{
      _player.pause();
    }
    isPlaying = !isPlaying;
  }

  Future<void> _init() async {
        //await _player.setAudioSource(AudioSource.uri(Uri.parse('https://codiceo.fr/mp3/civilisation.mp3')));
        await _player.setAsset('${myMusicList[range].urlSong}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title, textAlign: TextAlign.center, style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,))),
      ),
      backgroundColor: Color.fromARGB(255, 12, 12, 12),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
//IMAGE
            Image(
              image: AssetImage(myMusicList[range].imagePath),
            ),

            const SizedBox(
              height: 20,
            ),

//TITLE
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
              myMusicList[range].title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

//SINGER
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 15),
              child: Text(
              myMusicList[range].singer,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              ),
            ),

            

            const SizedBox(
              height: 20,
            ),

//SLIDER
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 100,
              thumbColor: Colors.white,
              activeColor: Colors.white,
              //label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
              setState(() {
              _currentSliderValue = value;
            });
          },
        ),

//TIME
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
              child: Container(
                margin: const EdgeInsets.only(left: 15),
              child: Text(
              '00.00',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              ),
            ),

                Align(
              child: Container(
                margin: const EdgeInsets.only(right: 15),
              child: Text(
              '5.25',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              ),
            ),
              ]
      ),
        

          
//ICON SKIP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.skip_previous, size: 40.0),
                  tooltip: 'Refresh',
                  onPressed: () {
                    setState(() {
                      if(range == 0){
                      range == myMusicList.length-1;
                    }else{
                      //_player.stop();
                      range--;
                    }
                    _init();
                    });
                    
                  },
                  color: Colors.white,
                ),

//ICON PLAY
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon((isPlaying == true) ? Icons.play_arrow:Icons.pause, size: 40.0),
                  //icon: Icon(Icons.play_arrow, size: 40.0),
                  onPressed: () {
                    setState(() {
                      play();
                    });
                  },
                  color: Colors.white,
                ),

//ICON SKIP
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.skip_next, size: 40.0),
                  tooltip: 'Refresh',
                  onPressed: () {
                    setState(() {
                      if(range == myMusicList.length-1){
                      range == myMusicList[0];
                    }else{
                      //_player.stop();
                      range++;
                    }
                    _init();
                    });
                    
                  },
                  color: Colors.white,
                ),
              ],
            ),

            
            
          ],
          
        ),
        
      ),

 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
