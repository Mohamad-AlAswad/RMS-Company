import 'package:flutter/material.dart';
import 'package:rms_company/domain/usecases/autocomplete/autocomplete_languages.dart';

import '../../../provider/theme.dart';
import '../../controllers/controllers.dart';
import '../custome_auto_complete.dart';

class LanguageItem extends StatefulWidget {
  const LanguageItem({
    Key? key,
    required this.enabled,
    required this.titles,
    required this.index,
    required this.languagesController,
    required this.delete,
    this.short = false,
    this.required,
  }) : super(key: key);

  final bool enabled, short;
  final List<String> titles;
  final int index;
  final LanguagesControllers languagesController;
  final Function(int) delete;
  final Function(bool)? required;

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  DateTime gDate = DateTime.now();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomeTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15).copyWith(right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.short) ...[
            Container(
              decoration: BoxDecoration(
                color: CustomeTheme.c2.withAlpha(70),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Required',
                    style: TextStyle(fontSize: 18),
                  ),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (val) {
                      if (widget.required != null) widget.required!(val!);
                      value = val!;
                    },
                    value: value,
                  ),
                ],
              ),
            ),
          ],
          Column(
            children: [
              CustomeAutoComplete(
                controller: widget.languagesController.title,
                autoApi: AutocompleteLanguages(),
                label: 'Title',
                enabled: widget.enabled,
                w: widget.short
                    ? 0.4
                    : widget.enabled
                        ? 0.7
                        : 0.8,
              ),
            ],
          ),
          if (widget.enabled) ...[
            IconButton(
              padding: const EdgeInsets.only(right: 1, bottom: 2),
              onPressed: () {
                widget.delete(widget.index);
              },
              icon: const Icon(
                Icons.delete,
                size: 40,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
