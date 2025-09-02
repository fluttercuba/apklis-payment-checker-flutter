package cu.fluttercuba.apklis_payment_checker

import android.content.Context
import android.content.pm.PackageManager
import android.net.Uri
import android.os.RemoteException

// Code from https://github.com/Z17-CU/apklischeckpayment
class Verify {
    companion object {

        private const val APKLIS_PROVIDER = "content://cu.uci.android.apklis.PaymentProvider/app/"
        private const val APKLIS_PAID = "paid"
        private const val APKLIS_USER_NAME = "user_name"

        fun isPurchased(context: Context, packageId: String): Pair<Boolean, String?> {
            var paid = false
            var userName: String? = null
            val providerURI: Uri = Uri.parse("$APKLIS_PROVIDER$packageId")
            try {
                val contentResolver =
                    context.contentResolver.acquireContentProviderClient(providerURI)
                val cursor = contentResolver?.query(providerURI, null, null, null, null)
                cursor?.let {
                    if (it.moveToFirst()) {
                        paid = it.getInt(it.getColumnIndexOrThrow(APKLIS_PAID)) > 0
                        userName = it.getString(it.getColumnIndexOrThrow(APKLIS_USER_NAME))
                    }
                }
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
                    contentResolver?.close()
                } else {
                    contentResolver?.release()
                }
                cursor?.close()
            } catch (e: RemoteException) {
                e.printStackTrace()
            } catch (e: IllegalArgumentException) {
                return Pair(false, null)
            }
            return Pair(paid, userName)
        }

        fun getApklisInfo(context: Context): Triple<Boolean, Int?, String?> {
            var isInstaller: Boolean
            var versionCode: Int? = null
            var versionName: String? = null

            val packageManager: PackageManager = context.packageManager
            try {
                isInstaller = true
                val info = packageManager.getPackageInfo(
                    "cu.uci.android.apklis",
                    PackageManager.GET_ACTIVITIES
                )
                versionName = info.versionName

                versionCode = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P) {
                    info.longVersionCode.toInt()
                } else {
                    info.versionCode
                }

            } catch (e: PackageManager.NameNotFoundException) {
                isInstaller = false
            }

            return Triple(isInstaller, versionCode, versionName)
        }
    }
}