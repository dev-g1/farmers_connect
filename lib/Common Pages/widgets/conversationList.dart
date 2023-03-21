import 'package:farmers_connect/Farmer/mylists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


MyLists myLists = MyLists();
class ConversationList extends StatefulWidget {
    String name;
    String messageText;
    String imageURL;
    String time;
    // bool isMessageRead;
  ConversationList(this.name, this.messageText, this.imageURL, this.time, );

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.imageURL),
              radius: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(widget.name),
                Text(widget.messageText)
              ],
            ),
      
            Text(widget.time)
          ],
        ),
      ),
    );
  }
}