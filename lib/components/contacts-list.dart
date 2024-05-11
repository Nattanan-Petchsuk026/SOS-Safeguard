import 'package:flutter/material.dart';
import 'package:sosapp/pages/contact-details.dart';

import '../app-contact.class.dart';
import 'contact-avatar.dart';

class ContactsList extends StatelessWidget {
  final List<AppContact> contacts;
  Function() reloadContacts;
  ContactsList({required Key key, required this.contacts, required this.reloadContacts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          AppContact contact = contacts[index];

          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ContactDetails(
                  contact: contact, // นี่คือการส่งค่า contact ไปยัง constructor ของ ContactDetails
                  onContactDelete: (AppContact _contact) {
                    reloadContacts();
                    Navigator.of(context).pop();
                  },
                  onContactUpdate: (AppContact _contact) {
                    reloadContacts();
                  },
                )
              ));
            },
            title: Text(contact.info.displayName ?? ''),
            subtitle: Text(
                contact.info.phones != null && contact.info.phones!.isNotEmpty ? contact.info.phones!.elementAt(0).value ?? '' : ''
            ),
            leading: ContactAvatar(contact, 36)
          );
        },
      ),
    );
  }
}
