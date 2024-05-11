import 'package:flutter/material.dart';
import 'package:sosapp/pages/contact-details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app-contact.class.dart';
import 'contact-avatar.dart';

class ContactsList extends StatelessWidget {
  final List<AppContact> contacts;
  final Function() reloadContacts;

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
                  contact: contact,
                  onContactDelete: (AppContact _contact) {
                    reloadContacts();
                    Navigator.of(context).pop();
                  },
                  onContactUpdate: (AppContact _contact) {
                    reloadContacts();
                  },
                ),
              ));
            },
            title: Text(contact.info.displayName ?? ''),
            subtitle: Text(
              contact.info.phones != null && contact.info.phones!.isNotEmpty ? contact.info.phones!.elementAt(0).value ?? '' : '',
            ),
            leading: ContactAvatar(contact, 36),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                _makePhoneCall(contact.info.phones != null && contact.info.phones!.isNotEmpty
                    ? contact.info.phones!.elementAt(0).value
                    : null);
              },
            ),
          );
        },
      ),
    );
  }

  void _makePhoneCall(String? phoneNumber) async {
    if (phoneNumber != null) {
      String uri = 'tel:$phoneNumber';
      try {
        await launch(uri);
      } catch (e) {
        print("Error: $e");
      }
    }
  }
}
