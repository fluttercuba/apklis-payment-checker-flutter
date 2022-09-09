package cu.fluttercuba.apklis_payment_checker

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ApklisPaymentCheckerPlugin */
class ApklisPaymentCheckerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "apklis_payment_checker")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPackageName" -> {
                val hashMap = HashMap<String, String?>()
                hashMap["packageName"] = context.packageName
                return result.success(hashMap)
            }
            "isPurchased" -> {
                val packageId = call.arguments<String>()
                val response = packageId?.let { Verify.isPurchased(context, it) }
                val hashMap = HashMap<String, Any?>()
                hashMap["paid"] = response?.first ?: false
                hashMap["username"] = response?.second
                return result.success(hashMap)
            }
            "getApklisInfo" -> {
                val response = Verify.getApklisInfo(context)
                val hashMap = HashMap<String, Any?>()
                hashMap["isIntalled" ] = response.first
                hashMap["versionCode"] = response.second
                hashMap["versionName"] = response.third
                return result.success(hashMap)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
