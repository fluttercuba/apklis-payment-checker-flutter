import 'dart:async';
import 'dart:developer';

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
  ApklisPaymentStatus status;

  @override
  void initState() {
    super.initState();
    setPackageName();
  }

  Future<void> setPackageName() async {
    try {
      var packageName = await ApklisPaymentChecker.getPackageName();
      setState(() => controller.text = packageName);
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> requestPaymentStatus(String packageId) async {
    try {
      var status = await ApklisPaymentChecker.isPurchased(packageId);
      setState(() => this.status = status);
    } on PlatformException catch (e) {
      log(e.toString());
    }
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
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
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
              if (status != null)
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text('Paid:'),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        status.paid.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text('Username:'),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        status.username ?? 'Unknow',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            if (keyForm.currentState.validate()) {
              final packageId = controller.text.trim();
              requestPaymentStatus(packageId);
            }
          },
        ),
      ),
    );
  }
}
