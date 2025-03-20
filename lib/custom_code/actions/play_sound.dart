// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:audioplayers/audioplayers.dart'; // Import the audio package

Future<void> playSound() async {
  // Initialize the AudioPlayer
  final player = AudioPlayer();

  // Path to audio file
  const audioPath = '/audio/notification_sound.mp3';

  try {
    // Play the audio file
    await player.play(AssetSource(audioPath));
  } catch (e) {
    // Log any errors if the playback fails
    print('Error playing audio: $e');
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
