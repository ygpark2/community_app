import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:commune_app/app/modules/web_home/models/board_item_store.dart';
import 'package:commune_app/app/modules/web_home/models/board_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mobx/mobx.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';

import 'widget/Board_item.dart';
import 'create_controller.dart';
import 'package:intl/intl.dart';


class CreatePage extends StatefulWidget {
  final int? id;
  const CreatePage({Key? key, this.id }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends ModularState<CreatePage, CreateController> {
  // use 'controller' variable to access controller

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];

  late ReactionDisposer whenDispose;

  @override
  void initState() {
    super.initState();
    store.setNewBoard(
      new BoardStore(
        id: 20, 
        title: null,
        amount: 0.0,
        qtItems: 0,
        selected: false,
        items: []
      )
    );

    if (widget.id != null) {
      store.prepareBoardToEdit(store.webHomeController.getBoard(widget.id!));
    } else {
      whenDispose = when(
        (r) => store.idNewBoard != null, 
        () => store.newBoard.id = store.idNewBoard
      );
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    if (whenDispose != null) {
      whenDispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Material(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              // enabled: false,
              autovalidateMode: AutovalidateMode.disabled,
              initialValue: {
                'movie_rating': 5,
                'best_language': 'Dart',
                'age': '13',
                'gender': 'Male',
                'text_area_test': 'default'
              },
              skipDisabled: true,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'age',
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _ageHasError = !(_formKey.currentState?.fields['age']
                            ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ]),
                    // initialValue: '12',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'text_area_test',
                    decoration: InputDecoration(
                      labelText: '내용',
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _ageHasError = !(_formKey.currentState?.fields['text_area_test']
                            ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(2000),
                      FormBuilderValidators.min(5),
                    ]),
                    maxLines: 5,
                    // initialValue: '12',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.none,
                  ),
                  FormBuilderDropdown<String>(
                    // autovalidate: true,
                    name: 'gender',
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      suffix: _genderHasError
                          ? const Icon(Icons.error)
                          : const Icon(Icons.check),
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: Text('Select Gender'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _genderHasError = !(_formKey
                            .currentState?.fields['gender']
                            ?.validate() ??
                            false);
                      });
                    },
                    valueTransformer: (val) => val?.toString(),
                  ),
                  FormBuilderRadioGroup<String>(
                    decoration: const InputDecoration(
                      labelText: 'My chosen language',
                    ),
                    initialValue: null,
                    name: 'best_language',
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                        .map((lang) => FormBuilderFieldOption(
                      value: lang,
                      child: Text(lang),
                    ))
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                  ),
                  FormBuilderSegmentedControl(
                    decoration: const InputDecoration(
                      labelText: 'Movie Rating (Archer)',
                    ),
                    name: 'movie_rating',
                    // initialValue: 1,
                    // textStyle: TextStyle(fontWeight: FontWeight.bold),
                    options: List.generate(5, (i) => i + 1)
                        .map((number) => FormBuilderFieldOption(
                      value: number,
                      child: Text(
                        number.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                        .toList(),
                    onChanged: _onChanged,
                  ),
                  FormBuilderSwitch(
                    title: const Text('I Accept the tems and conditions'),
                    name: 'accept_terms_switch',
                    initialValue: true,
                    onChanged: _onChanged,
                  ),
                  FormBuilderCheckboxGroup(
                    decoration: const InputDecoration(
                        labelText: 'The language of my people'),
                    name: 'languages',
                    // initialValue: const ['Dart'],
                    options: const [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                    separator: const VerticalDivider(
                      width: 10,
                      thickness: 5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        print(_formKey.currentState?.value);
                      } else {
                        print(_formKey.currentState?.value);
                        print('validation failed');
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}

