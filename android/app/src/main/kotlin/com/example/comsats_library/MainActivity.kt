package com.example.comsats_library

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.firebase.core.FirebaseCorePlugin

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine() {
    super.configureFlutterEngine()
    FirebaseCorePlugin.registerWith(flutterEngine!!)
  }
}
