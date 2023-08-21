import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/provider/services_provider.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';
import 'package:country_picker/country_picker.dart';

import '../../../widgets/stepper_bottom_control.dart';
import '../../../widgets/stepper_form.dart';

class PerosnalDetailPage extends ConsumerStatefulWidget {
  const PerosnalDetailPage(
      {Key? key, required this.id, required this.pagestate})
      : super(key: key);
  final int id;
  final int pagestate;
  @override
  PerosnalDetailPageState createState() => PerosnalDetailPageState();
}

class PerosnalDetailPageState extends ConsumerState<PerosnalDetailPage> {
  int initialPage = 0;

  final PageController controller = PageController(initialPage: 0);
  final addressFormkey = GlobalKey<FormState>();
  final TextEditingController line1 = TextEditingController();
  final TextEditingController line2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pinCode = TextEditingController();

  final TextEditingController mobileNo = TextEditingController();

  final TextEditingController nationalController = TextEditingController();
  final mobileNoFormkey = GlobalKey<FormState>();
  String? selectedGender;
  final TextEditingController dobController = TextEditingController();
  int _activeStepIndex = 0;
  List<Step> step() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const SizedBox.shrink(),
            content: ProfessionAddress(
              formKey: addressFormkey,
              city: city,
              line1: line1,
              line2: line2,
              pinCode: pinCode,
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const SizedBox.shrink(),
            content: ProfessionSex(
              selectedGender: selectedGender,
              onChanged: (val) {
                setState(() {
                  selectedGender = val;
                });
              },
            )),
        Step(
          state: _activeStepIndex <= 2 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const SizedBox.shrink(),
          content: ProfessionDob(dobController: dobController),
        ),
        Step(
            state:
                _activeStepIndex <= 3 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: const SizedBox.shrink(),
            content: ProfessionalNationality(
              nationalController: nationalController,
              onSelect: (Country country) {
                //print('Select country: ${country.displayName}');

                nationalController.text = country.displayName;
              },
            )),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 4,
          title: const SizedBox.shrink(),
          content: ProfessionalPhoneNumber(
              formKey: mobileNoFormkey, mobileControler: mobileNo),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarProgress(name: "Personal Details", progress: 0.2),
      body: CommonStepperForm(
          steps: step(),
          activeStepIndex: _activeStepIndex,
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepContinue: () {
            if (_activeStepIndex < (step().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
             // print('Submited');
            }
          },
          onStepTapped: (index) {
            setState(() {
              _activeStepIndex = index;
            });
          }),
      bottomNavigationBar: SteppereBottomControl(
        backFunction: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        continueFunction: () {
          if (_activeStepIndex < (step().length - 1)) {
            switch (_activeStepIndex) {
              case 0:
                if (addressFormkey.currentState!.validate()) {
                  setState(() {
                    _activeStepIndex++;
                  });
                }

                break;

              case 1:
                if (selectedGender != null) {
                  setState(() {
                    _activeStepIndex++;
                  });
                } else {
                  // "Please Select Gender".show context);
                }
                break;

              case 2:
                if (dobController.text.trim().isNotEmpty) {
                  setState(() {
                    _activeStepIndex++;
                  });
                }
                break;

              case 3:
                if (nationalController.text.trim().isNotEmpty) {
                  setState(() {
                    _activeStepIndex++;
                  });
                }
                break;

              case 4:
                if (mobileNoFormkey.currentState!.validate()) {
                  Navigator.pop(context);
                }
                break;

              default:
                Navigator.pop(context);
            }

            //   if(_activeStepIndex==

            //   if (_activeStepIndex == 0 &&
            //       addressFormkey.currentState!.validate()) {
            //     setState(() {
            //       _activeStepIndex += 1;
            //     });
            //   }
            //   if (_activeStepIndex == 1 && selectedGender == null) {
            //     "Please Select Gender".showErrorAlert(context);
            //   } else if (selectedGender != null) {
            //     setState(() {
            //       _activeStepIndex += 1;
            //     });
            //   }

            //   if (_activeStepIndex == 2 && dobController.text.trim().isEmpty) {
            //     "Please Selecte DOB".showErrorAlert(context);
            //   } else if (dobController.text.trim().isNotEmpty) {
            //     setState(() {
            //       _activeStepIndex++;
            //     });
            //   }
            // } else {
            //   Navigator.pop(context);
            //   // Navigator.push(
            //   //   context,
            //   //   MaterialPageRoute(
            //   //     builder: (context) => const SignupProfessional(),
            //   //   ),
            //   // );
          } else {
            if (widget.pagestate == 0 &&
                mobileNoFormkey.currentState!.validate()) {
              MProgressIndicator.show(context);
              ref
                  .read(authRepositoryProvider)
                  .userPersonalDetails(
                      address:
                          line1.text + line2.text + city.text + pinCode.text,
                      gender: selectedGender!,
                      dob: dobController.text,
                      conuntry: nationalController.text,
                      mobile: mobileNo.text)
                  .then((value) {
                if (value.success) {
                  MProgressIndicator.hide();
                  value.message.showSuccessAlert(context);
                  ref
                      .read(listingProvider.notifier)
                      .updateProfessionList(widget.id);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                  Navigator.pop(context);
                } else {
                  value.message.showErrorAlert(context);
                }
              });
              // Navigator.pop(context);
            }
            if (widget.pagestate == 1 &&
                mobileNoFormkey.currentState!.validate()) {
              MProgressIndicator.show(context);
              ref
                  .read(authRepositoryProvider)
                  .updatePersonalDetails(
                      address:
                          line1.text + line2.text + city.text + pinCode.text,
                      gender: selectedGender!,
                      dob: dobController.text,
                      conuntry: nationalController.text,
                      mobile: mobileNo.text)
                  .then((value) {
                if (value.success) {
                  MProgressIndicator.hide();
                  value.message.showSuccessAlert(context);
                  ref
                      .read(listingProvider.notifier)
                      .updateProfessionList(widget.id);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                  Navigator.pop(context);
                } else {
                  value.message.showErrorAlert(context);
                }
              });
              // Navigator.pop(context);
            }
          }
        },
        isShowBack: _activeStepIndex == 0,
      ),
    );
  }
}

class ProfessionAddress extends StatelessWidget {
  ProfessionAddress({
    super.key,
    required this.formKey,
    required this.city,
    required this.line1,
    required this.line2,
    required this.pinCode,
  });

  final TextEditingController line1;
  final TextEditingController line2;
  final TextEditingController city;
  final TextEditingController pinCode;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please enter your address",
            style: signUpHeadStyle,
          ),
          size10,
          Text(
            "To verify and identity and pay you correctly we'll need your address",
            style: signUpSubHeadStyle,
          ),
          size10,
          CustomTextFormField(
            controller: line1,
            label: "Line1",
            validator: (val) {
              if (val == null) {
                return "Required";
              } else if (pinCode.text.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          size10,
          CustomTextFormField(
            controller: line2,
            label: "Line2",
            validator: (val) {
              if (val == null) {
                return "Required";
              } else if (pinCode.text.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          size10,
          CustomTextFormField(
            controller: city,
            label: "City",
            validator: (val) {
              if (val == null) {
                return "Please Enter city";
              } else if (city.text.trim().isEmpty) {
                return "Please Enter city";
              }
              return null;
            },
          ),
          size10,
          CustomTextFormField(
            controller: pinCode,
            label: "Post code",
            validator: (val) {
              if (val == null) {
                return "Please Enter Pin code";
              } else if (pinCode.text.trim().isEmpty) {
                return "Please Enter Pin code";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class ProfessionSex extends StatefulWidget {
  ProfessionSex(
      {super.key, required this.selectedGender, required this.onChanged});
  String? selectedGender;
  Function(String?)? onChanged;
  @override
  State<ProfessionSex> createState() => _ProfessionSexState();
}

class _ProfessionSexState extends State<ProfessionSex> {
  final List<String> _sex = ["Male", "Female", "Other"];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your Gender?",
          style: signUpHeadStyle,
        ),
        size10,
        // Text(
        //   "We need this to check your right to wrok",
        //   style: signUpSubHeadStyle,
        // ),
        size10,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
              color: containerBackGroundColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: lightTextColor)),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            dropdownColor: containerBackGroundColor,
            hint: const Text("What’s your gender ?"),
            value: widget.selectedGender,
            onChanged: widget.onChanged,
            isDense: true,
            items: _sex.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class ProfessionDob extends StatefulWidget {
  ProfessionDob({super.key, required this.dobController});
  TextEditingController dobController;
  @override
  State<ProfessionDob> createState() => _ProfessionDobState();
}

class _ProfessionDobState extends State<ProfessionDob> {
  final TextEditingController _dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "What's your date of birth?",
          style: signUpHeadStyle,
        ),
        size10,
        Text(
          "This should match your passport",
          style: signUpSubHeadStyle,
        ),
        size10,
        Text(
          "Minimum age 18",
          style: TextStyle(color: Colors.redAccent),
        ),
        size10,
        InkWell(
          onTap: () async {
            showDatePicker(
                    context: context,
                    initialDate: DateTime(1951),
                    firstDate: DateTime(1950),
                    lastDate:
                        DateTime.now().subtract(Duration(days: (18 * 365))))
                .then((value) {
              widget.dobController.text = value.toString().substring(0, 10);
            });
          },
          child: CustomTextFormField(
            controller: widget.dobController,
            prefixICon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                SvgAsset.calender,
                color: kPrimaryColor,
              ),
            ),
            enable: false,
            label: "DOB",
            validator: (val) {
              return null;
            },
          ),
        )
      ],
    );
  }
}

class ProfessionalNationality extends StatelessWidget {
  ProfessionalNationality(
      {Key? key, required this.nationalController, required this.onSelect})
      : super(key: key);
  final TextEditingController nationalController;
  void Function(Country) onSelect;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Please select your nationality ?",
          style: signUpHeadStyle,
        ),
        size10,
        Text(
          "This should match your passport",
          style: signUpSubHeadStyle,
        ),
        size10,
        InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
              exclude: <String>['KN', 'MF'],
              favorite: <String>['SE'],
              //Optional. Shows phone code before the country name.
              showPhoneCode: true,
              onSelect: onSelect,
              //  (Country country) {
              //   print('Select country: ${country.displayName}');

              //   .text = country.displayName;
              // },
              // Optional. Sets the theme for the country list picker.
              countryListTheme: CountryListThemeData(
                // Optional. Sets the border radius for the bottomsheet.
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                // Optional. Styles the search field.
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
                // Optional. Styles the text in the search field
                searchTextStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            );
          },
          child: CustomTextFormField(
            enable: false,
            controller: nationalController,
            label: "Select Country",
            validator: (val) {
              return null;
            },
          ),
        )
      ],
    );
  }
}

class ProfessionalPhoneNumber extends StatelessWidget {
  ProfessionalPhoneNumber(
      {Key? key, required this.formKey, required this.mobileControler})
      : super(key: key);
  final TextEditingController mobileControler;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            "what's your phone number ?",
            style: signUpHeadStyle,
          ),
          size10,
          Text(
            "If we need to contact you,this is the number we will call you on",
            style: signUpSubHeadStyle,
          ),
          size10,
          CustomTextFormField(
            controller: mobileControler,
            inputType: TextInputType.number,
            enable: true,
            label: "Mobile Number",
            validator: (val) {
              if (val == null || mobileControler.text.trim().isEmpty) {
                return "Please Enter Mobile No";
              }

              if ((mobileControler.text.startsWith('0') &&
                      mobileControler.text.length == 11) ||
                  (!mobileControler.text.startsWith('0') &&
                      mobileControler.text.length == 10)) {
              } else {
                return "Invalid Mobile No";
              }
            },
          ),
        ],
      ),
    );
  }
}
