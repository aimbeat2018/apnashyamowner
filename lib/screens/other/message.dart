import 'package:flutter/material.dart';

import '../../constant/images/images.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  final String? date;
  final ScrollController? controller;
  const MessagesScreen(
      {Key? key, required this.messages, this.controller, this.date})
      : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        shrinkWrap: true,
        controller: widget.controller,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (widget.messages[index]['isUserMessage'])
                  const SizedBox()
                else
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(bestDeal),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.messages[index]['isUserMessage']
                              ? const Color.fromARGB(255, 45, 53, 168)
                              : Colors.white),
                      constraints: BoxConstraints(maxWidth: w * 2 / 3),
                      child: Text(
                        widget.messages[index]['message'].text.text[0],
                        style: TextStyle(
                            color: widget.messages[index]['isUserMessage']
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.date.toString())
                  ],
                ),
                if (widget.messages[index]['isUserMessage'])
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(seaSide),
                    ),
                  )
                else
                  const SizedBox()
              ],
            ),
          );
        },
        separatorBuilder: (_, i) =>
            const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
