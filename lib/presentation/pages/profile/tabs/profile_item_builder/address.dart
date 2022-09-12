import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/update_action_bar_actions_notification.dart';
import '../../../../components/components.dart';
import '../../../../controllers/controllers.dart';

class AddressBuilder extends StatelessWidget {
  const AddressBuilder({
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
        controller: companyController.address,
        color: Theme.of(context).primaryColor,
        icon: Icons.location_on_outlined,
        label: 'Address',
        w: 0.6,
      ),
    );
  }
}
