import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/update_action_bar_actions_notification.dart';
import '../../../../components/components.dart';
import '../../../../controllers/controllers.dart';

class CompanyNameBuilder extends StatelessWidget {
  const CompanyNameBuilder({
    Key? key,
    required this.companyController,
  }) : super(key: key);

  final CompanyController companyController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: RoundedTextField(
        enabled: Provider.of<UpdateActionBarActions>(context).edit,
        controller: companyController.name,
        color: Theme.of(context).primaryColor,
        icon: Icons.drive_file_rename_outline,
        label: 'Company Name',
        w: 0.6,
      ),
    );
  }
}
