import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosapp/app-contact.class.dart';
import 'package:sosapp/firebase_options.dart';
import 'package:sosapp/onboarding/onboardinng_view.dart';
import 'package:sosapp/widgets/bottom_screen/bottom_page.dart';

import 'components/contacts-list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;// ตรวจสอบว่าเป็นการเข้าใช้ครั้งแรกหรือไม่
  if (isFirstTime) {
    prefs.setBool('isFirstTime', false);
    runApp(const MyApp(initialRoute: OnboardingView()));
  } else {
    runApp(const MyApp(initialRoute: BottomPage()));
  }
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS emergency',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: initialRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  TextEditingController searchController = TextEditingController();
  bool contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<AppContact> _contacts =
        (await ContactsService.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return AppContact(info: contact, color: baseColor, key: null);
    }).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<AppContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.info.displayName?.toLowerCase() ?? '';
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.info.phones?.firstWhere(
          (phn) {
            String phnFlattened = flattenPhoneNumber(phn.value ?? '');
            return phnFlattened.contains(searchTermFlatten);
          },
        );

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist =
        ((isSearching == true && contactsFiltered.length > 0) ||
            (isSearching != true && contacts.length > 0));
      return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0083B0),Color(0xff6849ef)],
              //colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'รายชื่อผู้ติดต่อ',
          style: GoogleFonts.kanit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () async {
          try {
            Contact? contact = await ContactsService.openContactForm();
            if (contact != null) {
              getAllContacts();
            }
          } on FormOperationException catch (e) {
            switch (e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
                print(e.toString());
              case null:
              // TODO: Handle this case.
            }
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'ค้นหา',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
            contactsLoaded == true
                ? listItemsExist == true
                    ? ContactsList(
                        key: ValueKey(DateTime
                            .now()), // Provide a unique identifier for the key
                        reloadContacts: () {
                          getAllContacts();
                        },
                        contacts:
                            isSearching == true ? contactsFiltered : contacts,
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          isSearching
                              ? 'ไม่มีผลการค้นหาที่จะแสดง'
                              : 'ไม่มีรายชื่อที่อยู่ติดต่อ',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ))
                : Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
          
        ),
      ),
    );
  }
}
