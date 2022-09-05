import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rms_company/domain/usecases/authentication/connected_company_user.dart';
import 'package:rms_company/presentation/components/components.dart';

class CompanySelect extends StatefulWidget {
  const CompanySelect({Key? key}) : super(key: key);

  @override
  State<CompanySelect> createState() => _CompanySelectState();
}

class _CompanySelectState extends State<CompanySelect> {
  late List<String>? list = list = ConnectedCompanyUser().companyIds;
  late String? value;
  late TextEditingController company;
  late bool isValid;

  @override
  void initState() {
    super.initState();
    value = list != null ? list![0] : null;
    isValid = false;
    company = TextEditingController();
  }

  StreamSubscription? subscription;

  waitBeforeSending(String companyName) {
    if (subscription != null) subscription!.cancel();
    var future = Future.delayed(const Duration(milliseconds: 500));

    subscription = future.asStream().listen((_) async {
      if (companyName.isNotEmpty) {
        final bool valid = await check(companyName);
        setState(() {
          isValid = valid;
        });
      } else {
        isValid = false;
      }
    });
  }

  Future<bool> check(String companyName) async {
    bool valid = true;
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Almost Done',
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 50),
          const Text(
            'Select one of your Companies to complete log-in',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          RoundedDropdownButton(
            icon: Icons.work_outline_rounded,
            color: Theme.of(context).primaryColor,
            list: list,
            valueChanged: (val) {
              setState(() {
                value = val;
              });
            },
            value: value,
            label: 'your Companies',
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: MyElevatedButton(
              text: 'Log In',
              press: (value!.isNotEmpty)
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CustomeZoomDrawer(),
                        ),
                      );
                    }
                  : null,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            title: Expanded(
              child: Text(
                "Don't have a Company",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ),
            ),
            children: [
              RoundedTextField(
                onChange: waitBeforeSending,
                controller: company,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10),
              MyElevatedButton(
                text: 'Register',
                press: isValid
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CustomeZoomDrawer(),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
