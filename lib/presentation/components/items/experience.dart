import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/autocomplete/autocomplete_job_titles.dart';
import '../../../provider/theme.dart';
import '../../controllers/controllers.dart';
import '../custome_auto_complete.dart';
import '../my_elevated_button.dart';
import '../rounded_text_field.dart';

class PastExperienceItem extends StatefulWidget {
  const PastExperienceItem({
    Key? key,
    this.enabled = true,
    required this.titles,
    required this.index,
    required this.expController,
    required this.delete,
    this.short = false,
    this.sp = false,
    this.required,
  }) : super(key: key);

  final bool enabled, short, sp;
  final List<String> titles;
  final int index;
  final ExpControllers expController;
  final Function(int) delete;
  final Function(bool)? required;

  @override
  State<PastExperienceItem> createState() => _PastExperienceItemState();
}

class _PastExperienceItemState extends State<PastExperienceItem> {
  DateTime gDate = DateTime.now();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.sp) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(flex: 1),
              if (widget.short) ...[
                Container(
                  decoration: BoxDecoration(
                    color: CustomTheme.c2.withAlpha(70),
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
                        onChanged: (!widget.sp)
                            ? (val) {
                                if (widget.required != null) {
                                  widget.required!(val!);
                                }
                                value = val!;
                              }
                            : null,
                        value: value,
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(flex: 6),
            ],
          ),
        ],
        if (!widget.sp) ...[
          if (widget.enabled) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 1),
                if (widget.short) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: CustomTheme.c2.withAlpha(70),
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
                const Spacer(flex: 4),
                Container(
                  decoration: BoxDecoration(
                    color: CustomTheme.c2.withAlpha(70),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 1, bottom: 2),
                    onPressed: () {
                      widget.delete(widget.index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 40,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ],
        ],
        Container(
          decoration: BoxDecoration(
            color: CustomTheme.c2.withAlpha(70),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ).copyWith(
              topRight: Radius.circular(widget.enabled ? 0 : 10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              CustomeAutoComplete(
                controller: widget.expController.title,
                autoApi: AutocompleteJobTitles(),
                label: 'Title',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 20),
              if (!widget.short) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          (widget.enabled ? 0.47 : .8),
                      margin: EdgeInsets.only(right: (widget.enabled ? 10 : 0)),
                      child: RoundedTextField(
                        enabled: false,
                        controller: widget.expController.start,
                        color: Theme.of(context).primaryColor,
                        label: 'Start Date',
                      ),
                    ),
                    if (widget.enabled) ...[
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
                            (value) => setState(() {
                              if (value != null && value != gDate) {
                                gDate = value;
                                widget.expController.start.text =
                                    DateFormat.yMMMd().format(value);
                              }
                            }),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 20),
              ],
              RoundedTextField(
                enabled: widget.enabled,
                controller: widget.expController.duration,
                color: Theme.of(context).primaryColor,
                label: 'Duration (in Years)',
                isDouble: true,
                w: 0.8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
