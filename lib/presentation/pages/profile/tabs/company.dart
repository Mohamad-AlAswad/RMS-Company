import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/update_action_bar_actions_notification.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';
import 'profile_item_builder/profile_item_builder.dart';

class CompanyInformation extends StatefulWidget {
  const CompanyInformation({
    Key? key,
    required this.companyController,
  }) : super(key: key);

  final CompanyController companyController;

  @override
  State<CompanyInformation> createState() => _CompanyInformationState();
}

class _CompanyInformationState extends State<CompanyInformation> {
  late List<TextEditingController> phones;
  late List<TextEditingController> emails;
  late CompanyController companyController;

  late DateTime date;

  addPhone() {
    setState(() {
      phones.insert(phones.length, TextEditingController());
    });
  }

  removePhone(index) {
    setState(() {
      phones.removeAt(index);
    });
  }

  addEmail() {
    setState(() {
      emails.insert(emails.length, TextEditingController());
    });
  }

  removeEmail(index) {
    setState(() {
      emails.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    companyController = widget.companyController;
    phones = companyController.phones;
    emails = companyController.emails;
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    bool enabled = Provider.of<UpdateActionBarActions>(context).edit;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: mq.size.height,
        ),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              const SizedBox(height: 15),
              CompanyNameBuilder(companyController: companyController),
              AddressBuilder(companyController: companyController),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        (enabled ? 0.47 : .85),
                    margin: EdgeInsets.only(right: (enabled ? 10 : 0)),
                    child: RoundedTextField(
                      enabled: false,
                      controller: companyController.creationDate,
                      color: Theme.of(context).primaryColor,
                      label: 'Creation',
                    ),
                  ),
                  if (enabled) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: MyElevatedButton(
                        text: 'Pick A Date',
                        press: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2050),
                        ).then(
                          (value) => setState(
                            () {
                              if (value != null && value != date) {
                                date = value;
                                companyController.creationDate.text =
                                    DateFormat.yMMMd().format(value);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              PhoneList(phones: phones, add: addPhone, remove: removePhone),
              EmailList(emails: emails, add: addEmail, remove: removeEmail),
            ],
          ),
        ),
      ),
    );
  }
}
