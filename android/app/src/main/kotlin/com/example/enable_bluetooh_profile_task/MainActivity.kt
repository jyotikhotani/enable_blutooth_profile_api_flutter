package com.example.enable_bluetooh_profile_task

import android.bluetooth.BluetoothAdapter
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
 private val CHANNEL = "bluetooth_control"


  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "enableBluetooth") {
                enableBluetooth(result)
            } else {
                result.notImplemented()
            }
        }
    }

  private fun enableBluetooth(result: MethodChannel.Result) {
        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        if (bluetoothAdapter != null) {
            if (!bluetoothAdapter.isEnabled) {
                val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                startActivityForResult(enableBtIntent, 1)
                result.success("Bluetooth enabled")
            } else {
                result.success("Bluetooth already enabled")
            }
        } else {
            result.error("Bluetooth error", "Bluetooth is not supported on this device", null)
        }
    }

}
