import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/professional_detail_listing.dart';
import 'package:sterling/views/widgets/contimue_button.dart';

class AuthCompelteScreen extends ConsumerStatefulWidget {
  AuthCompelteScreen({Key? key, required this.value}) : super(key: key);
  final String value;

  @override
  ConsumerState<AuthCompelteScreen> createState() => _AuthCompelteScreenState();
}

class _AuthCompelteScreenState extends ConsumerState<AuthCompelteScreen> {
  Future<void> updateNMC() async {
    // Step 1: Read the list from SharedPreferences
    var todoList = await LocaldbHelper.getLisitingDetails();

    // Step 2: Find the record with id = 8 and update it
    int targetId = 8;
    int indexToUpdate = todoList.indexWhere((todo) => todo.id == targetId);
    if (indexToUpdate != -1) {
      var updatedTodo = todoList[indexToUpdate].copWith(isCompelete: true);
      todoList[indexToUpdate] = updatedTodo;
    }
    // Step 3: Save the updated list back to SharedPreferences
    await LocaldbHelper.saveListingDetails(list: todoList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateNMC();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight!;
    var width = SizeConfig.screenWidth!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: klightGreenColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        left: false,
        child: Column(
          children: [
            size20,
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                AppImages.globe,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: klightGreenColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(
                      40,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    size20,
                    Text(
                      "Profession",
                      style: codeProHeadStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Awesome work that means you are one step close to being completed !",
                        style: sourceCodeProStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    size20,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AppImages.compelte,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ContinueBotton(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessionalDetailListing(
                                      pagestate: 0,
                                    )),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
