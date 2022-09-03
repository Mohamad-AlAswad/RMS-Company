import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms_company/domain/usecases/autocomplete/autocomplete_degrees.dart';
import 'package:rms_company/domain/usecases/autocomplete/autocomplete_field_edu.dart';
import '../../../provider/theme.dart';
import '../../controllers/edu_controllers.dart';
import '../components.dart';
import '../custome_auto_complete.dart';

class EduQualificationItem extends StatefulWidget {
  const EduQualificationItem({
    Key? key,
    required this.enabled,
    required this.certificateNames,
    required this.degrees,
    required this.index,
    required this.eduControllers,
    required this.delete,
    this.required,
    this.short = false,
  }) : super(key: key);

  final bool enabled, short;
  final List<String> certificateNames;
  final List<String> degrees;
  final int index;
  final EduControllers eduControllers;
  final Function(int) delete;
  final Function(bool)? required;

  @override
  State<EduQualificationItem> createState() => _EduQualificationItemState();
}

class _EduQualificationItemState extends State<EduQualificationItem> {
  DateTime gDate = DateTime.now();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.enabled) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(flex: 1),
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
              const Spacer(flex: 4),
              Container(
                decoration: BoxDecoration(
                  color: CustomeTheme.c2.withAlpha(70),
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
        Container(
          decoration: BoxDecoration(
            color: CustomeTheme.c2.withAlpha(70),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ).copyWith(
              topRight: Radius.circular(widget.enabled ? 0 : 10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              if (!widget.short) ...[
                RoundedTextField(
                  color: Theme.of(context).primaryColor,
                  controller: widget.eduControllers.university,
                  label: 'University',
                  enabled: widget.enabled,
                  w: 0.8,
                ),
                const SizedBox(height: 10),
              ],
              CustomeAutoComplete(
                controller: widget.eduControllers.certificateName,
                autoEduApi: AutocompleteFieldEdu(),
                degreeController: widget.eduControllers.degree,
                label: 'Certificate Name',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
              CustomeAutoComplete(
                controller: widget.eduControllers.degree,
                autoApi: AutocompleteDegrees(),
                label: 'Degree',
                enabled: widget.enabled,
                w: 0.8,
              ),
              const SizedBox(height: 10),
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
                        controller: widget.eduControllers.graduation,
                        color: Theme.of(context).primaryColor,
                        label: 'Graduation',
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
                            (value) => setState(
                              () {
                                if (value != null && value != gDate) {
                                  gDate = value;
                                  widget.eduControllers.graduation.text =
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
              ],
            ],
          ),
        ),
      ],
    );
  }
}
