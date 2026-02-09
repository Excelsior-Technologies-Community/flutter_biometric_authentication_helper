# 🔐 Biometric Authentication Helper (Flutter)


A lightweight and reusable **Flutter helper** for authenticating users using
**Fingerprint** and **Face ID**.

Built on top of Flutter’s `local_auth` plugin, this helper simplifies biometric
authentication by providing a **clean API**, **proper error handling**, and
**library-ready structure**.
---

## ✨ Features


✅ Fingerprint authentication  
✅ Face ID authentication  
✅ Biometric hardware availability check  
✅ Get supported biometric types  
✅ Clean success / failure handling  
✅ Reusable helper (no UI coupling)  
✅ Library & production ready  
❌ No business logic inside UI  
 

---

## ✨ Preview



<img width="193" height="425" alt="Screenshot 2026-02-09 at 12 48 00 PM" src="https://github.com/user-attachments/assets/e4831f86-f148-456f-b8eb-5bd0f8cd79c0" />


---

## ✨ Installation
Add this to your package's pubspec.yaml file:
```
dependencies:
  biometric_auth_helper:
    path: ../biometric_auth_helper

```
▶️ From GitHub
```
dependencies:
  biometric_auth_helper:
    git:
      url: https://github.com/yourusername/biometric_auth_helper.git

```
Required Dependency
```
dependencies:
  local_auth: ^2.1.8

```
Then Run:
```
flutter pub get
```
## 📁 Folder Structure
```
biometric_auth_helper/
│
├── lib/
│   ├── biometric_auth_helper.dart   # Library export file
│   │
│   └── src/
│       ├── biometric_helper.dart    # Core biometric logic
│       └── biometric_exception.dart # (Optional) Custom exceptions
│
├── example/
│   └── lib/
│       └── main.dart                # Demo app using BiometricAuthHelper
│
├── screenshots/
│   ├── fingerprint_prompt.png
│   └── faceid_prompt.png
│
├── pubspec.yaml
├── README.md
└── LICENSE

  ```
## 🚀 Usage 

Biometric Helper Screen
```

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// 🔍 Check if biometric is available on device
  static Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// 📱 Get available biometric types
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
```

Demo Screen
```
import 'package:flutter/material.dart';
import 'package:biometric_auth_helper/biometric_auth_helper.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BiometricDemoScreen(),
    );
  }
}

class BiometricDemoScreen extends StatefulWidget {
  const BiometricDemoScreen({super.key});

  @override
  State<BiometricDemoScreen> createState() => _BiometricDemoScreenState();
}

class _BiometricDemoScreenState extends State<BiometricDemoScreen> {
  String _status = 'Not Authenticated';

  Future<void> _handleAuthentication() async {
    final isAvailable =
        await BiometricHelper.isBiometricAvailable();

    if (!isAvailable) {
      setState(() {
        _status = 'Biometric not available ❌';
      });
      return;
    }

    final success = await BiometricHelper.authenticate(
      reason: 'Verify your identity',
    );

    setState(() {
      _status = success
          ? 'Authentication Success ✅'
          : 'Authentication Failed ❌';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              _status,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleAuthentication,
              child: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}


```
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

