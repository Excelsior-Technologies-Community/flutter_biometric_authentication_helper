import 'package:flutter/material.dart';
import 'package:flutter_biometric_authentication_helper/biometric_authentication/biometric_helper.dart';

class BiometricDemoScreen extends StatefulWidget {
  const BiometricDemoScreen({super.key});

  @override
  State<BiometricDemoScreen> createState() => _BiometricDemoScreenState();
}

class _BiometricDemoScreenState extends State<BiometricDemoScreen> {
  String status = 'Not Authenticated';

  Future<void> _authenticate() async {
    final isAvailable = await BiometricHelper.isBiometricAvailable();

    if (!isAvailable) {
      setState(() => status = 'Biometric not available');
      return;
    }

    final success = await BiometricHelper.authenticate(
      reason: 'Unlock secure content',
    );

    setState(() {
      status = success ? 'Authentication Success ✅' : 'Authentication Failed ❌';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _authenticate,
              icon: const Icon(Icons.fingerprint),
              label: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}
