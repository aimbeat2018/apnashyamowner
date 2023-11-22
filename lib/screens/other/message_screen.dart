import 'dart:async';

import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors/colors.dart';
import '../../common/cust_text_field.dart';
import 'message.dart';

class HelpSupportMessageScreen extends StatefulWidget {
  const HelpSupportMessageScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportMessageScreen> createState() =>
      _HelpSupportMessageScreenState();
}

class _HelpSupportMessageScreenState extends State<HelpSupportMessageScreen> {
  //Dialog Flowtter For Chat Bot
  late DialogFlowtter dialogFlowtter;

  //TextEditingController
  final TextEditingController _controller = TextEditingController();

// List For Message
  List<Map<String, dynamic>> messages = [];

  // ScrollController To Navigate end of the page
  late ScrollController controller;
  String? date;

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    controller = ScrollController();
    super.initState();
  }

// Function to animate end of the page
  void _scrollDown() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
                child: MessagesScreen(
              messages: messages,
              controller: controller,
              date: date,
            )),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          keyboardType: TextInputType.multiline,
                          controller: _controller,
                          onFieldSubmitted: (p0) {
                            sendMessage(_controller.text);
                            _controller.clear();
                          },
                          maxLines: null,
                          color: AppColors.activeColor,
                          verticlePadding: 0.0,
                          hintText: 'Message...')),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 183, 129, 109),
                        shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          date = DateFormat('h:mm a').format(DateTime.now());
                          sendMessage(_controller.text);
                          _controller.clear();
                          Timer(const Duration(milliseconds: 100),
                              () => _scrollDown());
                          Timer(const Duration(milliseconds: 1000),
                              () => _scrollDown());
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function For Send Message
  sendMessage(String text) async {
    if (text.isEmpty) {
      debugPrint('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

//Function For add message in colunm(Screen)
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
