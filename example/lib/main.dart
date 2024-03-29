import 'dart:async';
import 'dart:developer';

import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:apklis_payment_checker/apklis_payment_checker.dart';
import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatefulWidget {
  @override
  ExampleAppState createState() => ExampleAppState();
}

class ExampleAppState extends State<ExampleApp> {
  final keyForm = GlobalKey<FormState>();
  final controller = TextEditingController();
  ApklisPaymentStatus? status;
  ApklisInfo? apklisInfo;

  @override
  void initState() {
    super.initState();
    setPackageName();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> setPackageName() async {
    try {
      final packageName = await ApklisPaymentChecker.getPackageName();
      setState(() => controller.text = packageName);
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> requestPaymentStatus(String packageId) async {
    try {
      final status = await ApklisPaymentChecker.isPurchased(packageId);
      setState(() => this.status = status);
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> getApklisInfo() async {
    final apklisInfo = await ApklisPaymentChecker.getApklisInfo();
    setState(() => this.apklisInfo = apklisInfo);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Apklis Payment Checker'),
        ),
        body: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Package Id',
                          hintText: 'com.example.nova.prosalud',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (status != null && apklisInfo != null)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: const Text('Apklis is installed:'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        apklisInfo?.isInstalled.toString() ?? 'false',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    if (apklisInfo?.isInstalled ?? false)
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text('Apklis version code:'),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              apklisInfo?.versionCode.toString() ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text('Apklis version name:'),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              apklisInfo?.versionName ?? 'Unknown',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text('Username registered in Apklis:'),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              status?.username ?? 'Unknow',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text('App payment status:'),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              status?.paid.toString() ?? 'Unknow',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            if (keyForm.currentState?.validate() ?? false) {
              final packageId = controller.text.trim();
              requestPaymentStatus(packageId);
              getApklisInfo();
            }
          },
        ),
      ),
    );
  }
}
