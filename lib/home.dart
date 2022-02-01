import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color impColor = Colors.green;

  TextEditingController _title = TextEditingController();
  TextEditingController _explanation = TextEditingController();

  List<dynamic> lst = [];
  List<dynamic> lst1 = [];

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: Icon(
          Icons.list_alt_outlined,
          size: 39,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(widget.title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 30.0,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 90,
            width: double.infinity,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                    Text("${DateTime.now().day}",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${months[DateTime.now().month - 1]}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("${DateTime.now().year}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.17),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                    Text("${days[DateTime.now().weekday - 1]}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
              ),
              child: (lst.isEmpty && lst1.isEmpty)
                  ? Center(
                      child: Text("Press + button to add something"),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: ListView.builder(
                          itemCount: lst.length,
                          itemBuilder: (context, index) {
                            // final item = lst[index];
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(() {
                                  lst.removeAt(index);
                                  lst1.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Done!')));
                              },
                              background: Container(
                                margin: EdgeInsets.only(top: 13, left: 5),
                                color: Colors.green,
                                alignment: AlignmentDirectional.centerStart,
                                //color: Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons.done,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              secondaryBackground: Container(
                                margin: EdgeInsets.only(top: 13, right: 5),
                                color: Colors.green,
                                alignment: AlignmentDirectional.centerEnd,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons.done,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: EdgeInsets.only(top: 8, right: 5, left: 5),
                                    child: GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.only(left: 25),
                                          title: Text("${lst[index]}", style: TextStyle(fontWeight: FontWeight.w600)),
                                          subtitle: Text(
                                            "${lst1[index]}",
                                            style: TextStyle(fontWeight: FontWeight.w600),
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text('Edit Todo',
                                                              style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                              )),
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              TextField(
                                                                cursorColor: Theme.of(context).primaryColor,
                                                                decoration: new InputDecoration(
                                                                  labelText: 'Title',
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                                  ),
                                                                ),
                                                                autofocus: true,
                                                                textCapitalization: TextCapitalization.sentences,
                                                                controller: _title,
                                                              ),
                                                              SizedBox(height: 10),
                                                              TextField(
                                                                maxLines: 5,
                                                                cursorColor: Theme.of(context).primaryColor,
                                                                decoration: new InputDecoration(
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                                  ),
                                                                  hintText: 'Explanation',
                                                                ),
                                                                autofocus: true,
                                                                textCapitalization: TextCapitalization.sentences,
                                                                controller: _explanation,
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Navigator.of(context).pop();
                                                                });
                                                              },
                                                              child: Text('CANCEL',
                                                                  style: TextStyle(
                                                                    color: Theme.of(context).primaryColor,
                                                                  )),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Navigator.of(context).pop();
                                                                  lst.add(_title.text);
                                                                  lst1.add(_explanation.text);
                                                                  _title.clear();
                                                                  _explanation.clear();
                                                                });
                                                              },
                                                              child: Text('UPDATE',
                                                                  style: TextStyle(
                                                                    color: Theme.of(context).primaryColor,
                                                                  )),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8, right: 15, left: 15),
                                    child: Icon(Icons.bookmark, color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add Todo',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: new InputDecoration(
                            labelText: 'Title',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            ),
                          ),
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _title,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          maxLines: 5,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: new InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            ),
                            hintText: 'Explanation',
                          ),
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _explanation,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('CANCEL',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                            lst.add(_title.text);
                            lst1.add(_explanation.text);
                            _title.clear();
                            _explanation.clear();
                          });
                        },
                        child: Text('ADD',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ],
                  );
                });
          },
          child: Icon(Icons.add, color: Colors.blue, size: 35),
        ),
      ),
    );
  }
}
