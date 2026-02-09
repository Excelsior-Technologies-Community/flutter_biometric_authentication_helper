import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// ✅ Check if biometric hardware is available
  static Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// 🔍 Get available biometric types
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }

  /// 🔐 Authenticate user
  static Future<bool> authenticate({
    String reason = 'Authenticate using biometrics',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}
