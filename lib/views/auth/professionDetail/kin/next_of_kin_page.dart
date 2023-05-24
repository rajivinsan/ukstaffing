import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/views/widgets/contimue_button.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';

import '../../../../provider/repository_provider.dart';
import '../../../../provider/services_provider.dart';
import '../../../../services/local_db_helper.dart';
import '../../../../utilities/ui/MProgressIndicator.dart';

class NextOfKinPage extends ConsumerWidget {
  NextOfKinPage({Key? key, required this.id}) : super(key: key);
  final int id;
  final TextEditingController kinName = TextEditingController();
  final TextEditingController kinPhone = TextEditingController();
  final TextEditingController kinRelationShip = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ContinueBotton(onTap: () {
          if (_formKey.currentState!.validate()) {
            MProgressIndicator.show(context);
            ref
                .read(authRepositoryProvider)
                .postKin(
                    kinNmae: kinName.text.trim(),
                    kinPhone: kinPhone.text.trim(),
                    relation: kinRelationShip.text.trim())
                .then((value) {
              MProgressIndicator.hide();
              if (value.success) {
                value.message.showSuccessAlert(context);
                ref.read(listingProvider.notifier).updateProfessionList(id);
                LocaldbHelper.saveListingDetails(
                  list: ref.watch(listingProvider),
                );
                Navigator.pop(context);
              } else {
                value.message.showErrorAlert(context);
              }
            });
          }
        }),
      ),
      appBar: const AppBarProgress(name: "Next of Kin", progress: 0.2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next of Kin",
                  style: sourceCodeProStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                size20,
                Text(
                  "Please provide details of your next of kin",
                  style: signUpSubHeadStyle,
                ),
                size20,
                size20,
                CustomTextFormField(
                  controller: kinName,
                  label: "Next of kin name",
                  validator: (vl) {
                    if (kinName.text.trim().isEmpty) {
                      return "please Enter Kin name";
                    }
                    return null;
                  },
                ),
                size20,
                size20,
                CustomTextFormField(
                  controller: kinPhone,
                  label: "Next of kin phone",
                  validator: (vl) {
                    if (kinPhone.text.trim().isEmpty) {
                      return "please Enter Kin phone";
                    }
                    if ((kinPhone.text.startsWith('0') &&
                            kinPhone.text.length == 11) ||
                        (!kinPhone.text.startsWith('0') &&
                            kinPhone.text.length == 10)) {
                    } else {
                      return "Invalid Mobile No";
                    }
                    return null;
                  },
                ),
                size20,
                size20,
                CustomTextFormField(
                  controller: kinRelationShip,
                  label: "Relationship to next of kin",
                  validator: (vl) {
                    if (kinRelationShip.text.trim().isEmpty) {
                      return "please Enter Kin Relationship";
                    }
                    return null;
                  },
                ),
                size20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
