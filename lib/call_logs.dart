import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallLogs extends StatefulWidget {
  @override
  _CallLogsState createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  List<String> contactsDataList = [];
  List<String> namesDataList = [];

  final String _contactsDataListKey = "ContactsDataList";
  final String _namesDataListKey = "NamesDataList";
  //final String _durationDataListKey = "DurationDataList";

  getCallLogData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      namesDataList = sharedPreferences.getStringList(_namesDataListKey);
      contactsDataList = sharedPreferences.getStringList(_contactsDataListKey);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCallLogData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Call Logs'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.timer,
                size: 45,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: namesDataList.length != 0
          ? CallLogsItems(
              contactsList: contactsDataList, namesList: namesDataList)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class CallLogsItems extends StatelessWidget {
  CallLogsItems({@required this.contactsList, @required this.namesList});

  final List contactsList;
  final List namesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: namesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(namesList[index]),
          subtitle: Text(contactsList[index]),
        );
      },
    );
  }
}
