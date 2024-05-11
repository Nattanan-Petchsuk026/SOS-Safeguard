import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:sosapp/components/contact-avatar.dart';

import '../app-contact.class.dart';

class ContactDetails extends StatefulWidget {
  ContactDetails({
    required this.contact,
    required this.onContactUpdate,
    required this.onContactDelete,
  });

  final AppContact contact;
  final Function(AppContact) onContactUpdate;
  final Function(AppContact) onContactDelete;

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    List<String> actions = <String>[
      'แก้ไข',
      'ลบ'
    ];

    void showDeleteConfirmation() {
      Widget cancelButton = TextButton(
        child: Text('ยกเลิก',style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget deleteButton = TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: Text(
        'ลบ',
        style: TextStyle(color: Colors.black), 
       ),
        onPressed: () async {
          await ContactsService.deleteContact(widget.contact.info);
          widget.onContactDelete(widget.contact);
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert= AlertDialog(
        title: Text('ลบรายชื่อ?'),
        content: Text('คุณแน่ใจหรือไม่ว่าต้องการลบรายชื่อที่อยู่ติดต่อนี้?'),
        backgroundColor: Colors.white, 
        actions: <Widget>[
          cancelButton,
          deleteButton
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
      );
    }

    void onAction(String action) async {
      switch(action) {
        case 'แก้ไข':
          try {
            Contact updatedContact = await ContactsService.openExistingContact(widget.contact.info);
            setState(() {
              widget.contact.info = updatedContact;
            });
            widget.onContactUpdate(widget.contact);
          } on FormOperationException catch (e) {
            switch(e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
                print(e.toString());
              case null:
                // TODO: Handle this case.
            }
          }
          break;
        case 'ลบ':
          showDeleteConfirmation();
          break;
      }
      print(action);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Center(child: ContactAvatar(widget.contact, 100)),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                        onSelected: onAction,
                        itemBuilder: (BuildContext context) {
                          return actions.map((String action) {
                            return PopupMenuItem(
                              value: action,
                              child: Text(action),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  title: Text("ชื่อ"),
                  trailing: Text(widget.contact.info.givenName ?? ""),
                ),
                ListTile(
                  title: Text("ชื่อสมาชิกในครอบครัว"),
                  trailing: Text(widget.contact.info.familyName ?? ""),
                ),
                Column(
                  children: <Widget>[
                    ListTile(title: Text("เบอร์")),
                    Column(
                      children: widget.contact.info.phones!
                        .map(
                          (i) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListTile(
                              title: Text(i.label ?? ""),
                              trailing: Text(i.value ?? ""),
                            ),
                          ),
                        )
                        .toList(),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
