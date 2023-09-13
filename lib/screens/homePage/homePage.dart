import 'package:flutter/material.dart';
import 'package:googletrasnlator/model/myModel.dart';
import '../../constant/constant.dart';
import '../../customWidgets/customButton.dart';
import '../../customWidgets/customTextFormFiled.dart';
import '../../services/apiHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLanguage1 = "English";
  String selectedLanguage2 = "Hindi";
  Map<String, dynamic> result = {};
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  late MyModel myModel;
  String source = "en";
  String target = "hi";
  String textToTranslate = "Translate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 22, 24, 1),
      body: SafeArea(
        child: isLargeScreen(context)
            ? Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    color: Color(0xff3a3b3d),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/gt.png'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildContent(),
                  ),
                ],
              )
            : buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Text Translation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xffbdbec0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade700,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  buttonText: selectedLanguage1,
                  onPressed: () async {
                    controller1.dispose();
                    controller1 = TextEditingController();
                    controller2.dispose();
                    controller2 = TextEditingController();
                    result = (await showLanguageBottomSheet(context))!;
                    if (result.isNotEmpty) {
                      setState(() {
                        selectedLanguage1 = result["name"];
                        source = result["code"];
                      });
                    }
                  },
                ),
                const Column(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
                CustomButton(
                  buttonText: selectedLanguage2,
                  onPressed: () async {
                    controller2.dispose();
                    controller2 = TextEditingController();
                    result = (await showLanguageBottomSheet(context))!;
                    if (result.isNotEmpty) {
                      setState(() {
                        selectedLanguage2 = result["name"];
                        target = result["code"];
                      });
                    }
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Translate from Hindi ",
              style: TextStyle(color: Color(0xffbdbec0)),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              myController: controller1,
              maxLength: 300,
              onChanged: (text) {
                if (text.isNotEmpty) {
                  ApiHelper()
                      .translateText(source, target, text)
                      .then((translatedText) {
                    if (translatedText != null) {
                      controller2.text = translatedText
                          .data!.translations![0].translatedText
                          .toString();
                    }
                  }).catchError((error) {
                    // Handle API error here
                    print('API Error: $error');
                  });
                } else {
                  controller1.text = "Translate";
                  setState(() {});
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Translate from English ",
              style: TextStyle(color: Color(0xffbdbec0)),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<MyModel>(
              future:
                  ApiHelper().translateText(source, target, controller1.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text(
                    'Something went wrong ',
                    style: TextStyle(color: Colors.white),
                  );
                } else if (snapshot.hasData) {
                  controller2.text = snapshot
                      .data!.data!.translations![0].translatedText
                      .toString();
                  return CustomTextFormField(
                    myController: controller2,
                    maxLength: 300,
                    onChanged: (text) {
                      // Handle onChanged events here
                    },
                  );
                } else {
                  return Container(); // Return an empty container if no data or error
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
