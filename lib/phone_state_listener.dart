import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneStateListener extends ChangeNotifier {
  // Correct event channel name for phone state
  static const EventChannel _eventChannel = EventChannel('PHONE_STATE_STREAM');

  Stream<String>? _phoneStateStream;

  DateTime? _callStartTime;
  Duration? _callDuration;

  PhoneStateListener() {
    listenToPhoneState();
  }
  void _updateCallDuration() {
    if (_callStartTime != null) {
      _callDuration = DateTime.now().difference(_callStartTime!);
      notifyListeners(); // This is key for updating the UI
    }
  }

  Duration? get callDuration => _callDuration;
  Stream<String> get phoneStateStream {
    _phoneStateStream ??= _eventChannel
        .receiveBroadcastStream()
        .map<String>((dynamic event) => event.toString());
    return _phoneStateStream!;
  }

  void listenToPhoneState() {
    phoneStateStream.listen(
      (state) {
        switch (state) {
          case 'OFFHOOK':
            _callStartTime = DateTime.now();
            _updateCallDuration();
            break;
          case 'IDLE':
            if (_callStartTime != null) {
              _updateCallDuration();
              _callStartTime = null;
            }
            break;
          case 'RINGING':
            break;
          // No default case needed
        }
      },
      onError: (error) => print('Error listening to phone state: $error'),
    );
  }
}
