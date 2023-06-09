// import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:pointer_interceptor/pointer_interceptor.dart';

// class UnityMainScreen extends StatefulWidget {
//   const UnityMainScreen({Key? key}) : super(key: key);

//   @override
//   _UnityMainScreenState createState() => _UnityMainScreenState();
// }

// class _UnityMainScreenState extends State<UnityMainScreen> {
//   late UnityWidgetController _unityWidgetController;
//   double _sliderValue = 0.0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _unityWidgetController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('API Screen'),
//       ),
//       body: Card(
//         margin: const EdgeInsets.all(8),
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Stack(
//           children: [
//             Container(
//               child: UnityWidget(
//                 onUnityCreated: onUnityCreated,
//                 onUnityMessage: onUnityMessage,
//                 onUnitySceneLoaded: onUnitySceneLoaded,
//                 fullscreen: false,
//                 useAndroidViewSurface: false,
//               ),
//             ),
//             PointerInterceptor(
//               child: Positioned(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//                 child: Card(
//                   elevation: 10,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Text("Rotation speed:"),
//                       ),
//                       Slider(
//                         onChanged: (value) {
//                           setState(() {
//                             _sliderValue = value;
//                           });
//                           setRotationSpeed(value.toString());
//                         },
//                         value: _sliderValue,
//                         min: 0,
//                         max: 20,
//                       ),
//                       FittedBox(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             MaterialButton(
//                               onPressed: () {
//                                 _unityWidgetController.quit();
//                               },
//                               child: Text("Quit"),
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 _unityWidgetController.create();
//                               },
//                               child: Text("Create"),
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 _unityWidgetController.pause();
//                               },
//                               child: Text("Pause"),
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 _unityWidgetController.resume();
//                               },
//                               child: Text("Resume"),
//                             ),
//                           ],
//                         ),
//                       ),
//                       FittedBox(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             MaterialButton(
//                               onPressed: () async {
//                                 await _unityWidgetController.openInNativeProcess();
//                               },
//                               child: Text("Open Native"),
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 _unityWidgetController.unload();
//                               },
//                               child: Text("Unload"),
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 _unityWidgetController.quit();
//                               },
//                               child: Text("Silent Quit"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void setRotationSpeed(String speed) {
//     _unityWidgetController.postMessage(
//       'Cube',
//       'SetRotationSpeed',
//       speed,
//     );
//   }

//   void onUnityMessage(message) {
//     print('Received message from unity: ${message.toString()}');
//   }

//   void onUnitySceneLoaded(SceneLoaded? scene) {
//     print('Received scene loaded from unity: ${scene?.name}');
//     print('Received scene loaded from unity buildIndex: ${scene?.buildIndex}');
//   }

//   // Callback that connects the created controller to the unity controller
//   void onUnityCreated(controller) {
//     this._unityWidgetController = controller;
//   }
// }

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class UnityMainScreen extends StatefulWidget {
  UnityMainScreen({Key? key}) : super(key: key);

  @override
  _UnityMainScreenState createState() => _UnityMainScreenState();
}

class _UnityMainScreenState extends State<UnityMainScreen> {
  late UnityWidgetController _unityWidgetController;
  final audioPlayerLeave = AudioPlayer();

  _triggerAudioLeave() async {
    await audioPlayerLeave.setSourceUrl("https://firebasestorage.googleapis.com/v0/b/gamesinc-11101.appspot.com/o/AppAssetSounds%2Fleave%2Fbye01.mp3?alt=media&token=1b406a71-08a2-4f58-864d-f799876d73f1");
    await audioPlayerLeave.resume();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: DraggableFab(
        child: Padding(
          padding: EdgeInsets.only(top: 0.0, right: 0),
          child: FloatingActionButton(
            mini: true,
            child: const Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              Navigator.pop(context);
              _triggerAudioLeave();
            },
            backgroundColor: Colors.black,
            // backgroundColor: Color.fromRGBO(0, 145, 174, 1),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Card(
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Container(
              child: UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
                fullscreen: true,
                useAndroidViewSurface: true,
                // fullscreen: true,
                // useAndroidViewSurface: false,
                // printSetupLog: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    print("\n ## onUnityCreated##");
    _unityWidgetController.postMessage('onUnityCreatedObject', 'onUnityCreated', '9999999');
  }

  _triggerUnityFuntion({required var message}) {
    var eventType = message['eventType'];

    switch (eventType) {
      case 'test01':
        print("eventType: $eventType");
        print("\n ## test01 ## - add random document to Firestore");
        break;
      case 'updateFirestoreCoins':
        print("eventType: $eventType");
        //!update do firestore the new value of "currentPlayerPrizeCoins"
        int currentPlayerPrizeCoins = int.parse(message['currentPlayerPrizeCoins']);
        break;
      case 'listStatsEventPlay2':
        print("eventType: $eventType");
        //! add firestore new eventPlay
        int currentPlayerPrizeCoins = int.parse(message['currentPlayerPrizeCoins']);
        String gameName = message['gameName'];

        break;
      default:
        print("eventType: $eventType");
    }
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    Map<String, dynamic> data = jsonDecode(message);
    _triggerUnityFuntion(message: data);
  }

  void onUnitySceneLoaded(SceneLoaded) {
    print("\n\n ## SceneLoaded ##");
  }
}
