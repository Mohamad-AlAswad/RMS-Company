import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rms_company/domain/usecases/%20company/check_company.dart';
import 'package:rms_company/domain/usecases/%20company/register_company.dart';
import 'package:rms_company/domain/usecases/authentication/get_connected_user.dart';
import 'package:rms_company/presentation/components/components.dart';


class CompanySelect extends StatefulWidget {
  const CompanySelect({Key? key}) : super(key: key);

  @override
  State<CompanySelect> createState() => _CompanySelectState();
}

class _CompanySelectState extends State<CompanySelect> {
  late List<String>? list;
  late String? value;
  late TextEditingController company;
  late bool isValid;

  @override
  void initState() {
    super.initState();
    list = GetConnectedUser().companies;
    value = list != null && list!.isNotEmpty ? list![0] : null;
    isValid = false;
    company = TextEditingController();
  }

  StreamSubscription? subscription;

  waitBeforeSending(String companyName) {
    setState(() {
      isValid = false;
    });
    if (subscription != null) subscription!.cancel();
    var future = Future.delayed(const Duration(milliseconds: 500));

    subscription = future.asStream().listen((_) async {
      if (companyName.isNotEmpty) {
        final bool valid = await CheckCompany()(company: companyName);
        setState(() {
          isValid = valid;
        });
      } else {
        isValid = false;
      }
    });
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
            icon: Icons.refresh,
            color: Theme.of(context).primaryColor,
            list: list,
            valueChanged: (val) {
              setState(() {
                value = val;
              });
            },
            value: value,
            label: 'your Companies',
            onRefresh: (){
              return GetConnectedUser().companies;
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: MyElevatedButton(
              text: 'Log In',
              press: (value != null && value!.isNotEmpty)
                  ? () {
                      GetConnectedUser().connectedCompany = value;
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
            title: Text(
              "Don't have a Company",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18),
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
                        RegisterCompany()(company: company.text);
                        // GetConnectedUser().connectedCompany = company.text;
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => const CustomeZoomDrawer(),
                        //   ),
                        // );
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
