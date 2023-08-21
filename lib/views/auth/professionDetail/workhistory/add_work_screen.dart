import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';

import '../../../../provider/services_provider.dart';

class AddWorkScreen extends ConsumerStatefulWidget {
  const AddWorkScreen({Key? key}) : super(key: key);

  @override
  AddWorkScreenState createState() => AddWorkScreenState();
}

class AddWorkScreenState extends ConsumerState<AddWorkScreen> {
  final TextEditingController _employer = TextEditingController();

  final TextEditingController _startDate = TextEditingController();

  final TextEditingController _endDate = TextEditingController();

  final formkey = GlobalKey<FormState>();

  String? startDate;

  String? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Add Experience",
          style: sourceSansStyle.copyWith(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name of employer",
                style: textFiledLabelStyle,
              ),
              size10,
              CustomTextFormField(
                label: "Employer",
                controller: _employer,
                validator: (val) {
                  if (val!.isEmpty || val == "") {
                    return "Please Enter Employer Name";
                  }
                  return null;
                },
              ),
              size10,
              Text(
                "Start Date",
                style: textFiledLabelStyle,
              ),
              size10,
              CustomTextFormField(
                sufficIcon: InkWell(
                    onTap: () async {
                      startDate = await _selectDate(context);
                      _startDate.text = startDate!;
                      setState(() {});
                    },
                    child: Icon(Icons.date_range)),
                //enable: false,
                textInputAction: TextInputAction.none,
                inputType: TextInputType.none,
                validator: (val) {
                  if (val!.isEmpty || val == "") {
                    return "Please Enter Start Date";
                  }
                  return null;
                },
                label: "Date",
                controller: _startDate,
              ),
              size10,
              Text(
                "End Date\n(if you are currently working then select today's date)",
                style: textFiledLabelStyle,
              ),
              size10,
              CustomTextFormField(
                //  enable: false,
                sufficIcon: InkWell(
                  onTap: () async {
                    endDate = await _selectDate(context);
                    _endDate.text = endDate!;
                    setState(() {});
                  },
                  child: const Icon(Icons.date_range),
                ),
                textInputAction: TextInputAction.none,
                inputType: TextInputType.none,
                label: "Date",
                controller: _endDate,
                validator: (val) {
                  if (val!.isEmpty || val == "") {
                    return "Please Enter End Date";
                  }
                  return null;
                },
              ),
              size10,
              size20,
              InkWell(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    String? token = await LocaldbHelper.getToken();
                    if (_startDate.text.isNotEmpty) {
                      ref.read(workListProvider.notifier).addWork(
                          employerName: _employer.text,
                          startDate: _startDate.text,
                          cid: int.parse(token!),
                          endDate: _endDate.text);
                      if (kDebugMode) {
                       // print(ref.watch(workListProvider).toString());
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      // ignore: use_build_context_synchronously
                      "Please Provide Start Date".showErrorAlert(context);
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kPrimaryColor,
                  ),
                  child: Text(
                    "Add Work".capitalize(),
                    textAlign: TextAlign.center,
                    style: codeProHeadStyle.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return picked.toString().substring(0, 10);
    } else {
      return "";
    }
  }
}
