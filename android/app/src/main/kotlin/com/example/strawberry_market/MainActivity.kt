package com.example.strawberry_market

import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("38ad7218-7819-4af7-84a7-4bab9d060af2")
        super.configureFlutterEngine(flutterEngine)
    }
}
