import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_ven_105_5_fm/ui/components/drawer/custom_drawer.dart';
import 'package:radio_ven_105_5_fm/widgets/appBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:radio_ven_105_5_fm/common.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class RadioScreen extends StatefulWidget {
   
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> with SingleTickerProviderStateMixin {
  final APpBar _appBar = APpBar();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle styleTituloEnc = GoogleFonts.ubuntu(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle styleTitulo = GoogleFonts.ubuntu(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle styleSubTitulo = GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white);
  TextStyle styleDetalle = GoogleFonts.ubuntu(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white);
  TextStyle styleLabel = GoogleFonts.ubuntu(fontSize: 11, fontWeight: FontWeight.w300, color: Colors.white);

    final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Oops! ❌',
      message: 'Parece que hay un problema de conexión. Verifique su internet.',
      contentType: ContentType.failure,
    ),
  );

  static int _nextMediaId = 0;
  late AudioPlayer _player;
  late Timer _visualizerTimer;
  bool _isPlaying = false;
  final Random _random = Random();
  List<double> _barHeights = List.generate(15, (_) => 10.0);

// filepath: c:\PROYECTOS\v\radio_ven2.0-main\lib\radio_screen.dart
static final _playlist = [
  AudioSource.uri(
    Uri.parse("https://streaming.serveraudio.net/stream/radioven1055"),
    tag: MediaItem(
      id: '${_nextMediaId++}',
      artist: "Radio VEN Voz Evangélica Nacional",
      album: "Radio VEN",
      title: "105.5 FM",
      artUri: Uri.parse("https://radioven.com/wp-content/uploads/2020/06/logo-ven.png"),
    ),
  ),
];
  final int _addedCount = 0;
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer(maxSkipsOnError: 3);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
    _player.play();
    _startVisualizer();
  }

@override
Future<void> _init() async {
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.speech());
  _player.errorStream.listen((e) {
    print('A stream error occurred: $e');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    });
  });
  try {
    await _player.setAudioSources(_playlist,
        preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
  } on PlayerException catch (e) {
    print("Error loading playlist: $e");
  }
  _player.positionDiscontinuityStream.listen((discontinuity) {
    if (discontinuity.reason == PositionDiscontinuityReason.autoAdvance) {
      _showItemFinished(discontinuity.previousEvent.currentIndex);
    }
  });
  _player.processingStateStream.listen((state) {
    if (state == ProcessingState.completed) {
      _showItemFinished(_player.currentIndex);
    }
  });
}

  void _showItemFinished(int? index) {
    if (index == null) return;
    final sequence = _player.sequence;
    if (index >= sequence.length) return;
    final source = sequence[index];
    final metadata = source.tag as MediaItem;
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text('Finished playing ${metadata.title}'),
      duration: const Duration(seconds: 1),
    ));
  }

  void _startVisualizer() {
    _visualizerTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {
        setState(() {
          _isPlaying = _player.playing;
          if (_isPlaying) {
            _barHeights = List.generate(15, (_) => _random.nextDouble() * 45 + 5);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _visualizerTimer.cancel();
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.detached) {
    _player.stop(); // Detiene el servicio cuando la aplicación se cierra
  }
}

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        key: _scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF310050), Color(0xFF493087)],
            ),
          ),
          child: _appBar.GetAppBarHome(' ', false, context, _scaffoldKey),
        ),
      ),
        body: Container(
           width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF310050), Color(0xFF493087)],
              ),
            ),
          child: Center(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder<SequenceState?>(
                      stream: _player.sequenceStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        if (state?.sequence.isEmpty ?? true) {
                          return const SizedBox();
                        }
                        final metadata = state!.currentSource!.tag as MediaItem;
                        return Column(
                          ///crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text('', style: styleTituloEnc),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Center(
                                    child: SizedBox(
                                    width: 600,
                                    height: 600,
                                      child: Image.asset( "assets/rvlogo.png", width: 600, height: 600,),
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(15, (index) {
                                  return AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    width: 4,
                                    height: _barHeights[index],
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                        colors: [Color.fromRGBO(240, 135, 31, 1), Colors.blueAccent],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Text('105.5 FM', style: styleTitulo),
                                  Text('Voz Evangélica Nacional', style: styleSubTitulo),
                                ],
                              ),
                            ),
                            
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ControlButtons(_player),
                  ),
                 
                  SizedBox(height: 8.0),
              
                  SizedBox(
                    height: 240.0,
                    child: StreamBuilder<SequenceState?>(
                      stream: _player.sequenceStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        final sequence = state?.sequence ?? [];
                        return ReorderableListView(
                          onReorder: (int oldIndex, int newIndex) {
                            if (oldIndex < newIndex) newIndex--;
                            _player.moveAudioSource(oldIndex, newIndex);
                          },
                          children: [
                            
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 35),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF310050), Color(0xFF493087)],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 4),
              Text('©️ La Batalla de la Fe, Inc.', style: styleLabel),
            ],
          ),
        ),
        ),

    
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
    
 
        StreamBuilder<(bool, ProcessingState, int)>(
          stream: Rx.combineLatest3(
              player.playingStream,
              player.playbackEventStream,
              player.sequenceStream,
              (playing, event, sequence) =>
                  (playing, event.processingState, sequence.length)),
          builder: (context, snapshot) {
            final (playing, processingState, sequenceLength) =
                snapshot.data ?? (false, null, 0);
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(color: Colors.white),
              );
            } else if (!playing) {
              return IconButton(
                icon: const Icon(Icons.play_arrow,color: Colors.white),
                iconSize: 48.0,
                onPressed: sequenceLength > 0 ? player.play : null,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause,color: Colors.white),
                iconSize: 48.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay,color: Colors.white),
                iconSize: 48.0,
                onPressed: sequenceLength > 0
                    ? () => player.seek(Duration.zero,
                        index: player.effectiveIndices.first)
                    : null,
              );
            }
          },
        ),

        
      ],
    );
    
  }
  
}