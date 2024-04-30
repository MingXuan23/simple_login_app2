import 'package:flutter/material.dart';
import 'package:simple_login_app2/model/role.dart';
import 'package:simple_login_app2/repo/role_repo.dart';
import 'package:simple_login_app2/repo/user_repo.dart';
import 'package:simple_login_app2/widget/alertMessage.dart';
import 'package:simple_login_app2/widget/userTile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Role> roleItem = [Role(0, "Select The Rule")];
  String? pickerSelectedValue;
  List<dynamic> userlist =[];
  List<dynamic> resultUserList = [];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRoles();
    
    getManagerUserList();
    

    
  }

  Future<List<dynamic>> getUserRoles() async{
    final list = await getRoles() as List<Role>;

    setState(() {
      roleItem = list;
    });

    return list;
  }
  Future<List<dynamic>> getManagerUserList() async{
     userlist = await ManagerGetUsers();
      setState(()  {
        userlist =userlist;
    });

    return userlist;
    //the second way, please try to implement
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
                hint: Text('Select the role'),
                value: pickerSelectedValue??roleItem[0].id.toString(), // Set initial value if available
                onChanged: (String? newValue) {
                  // Handle item selection
                  if(newValue ==null){
                    return;
                  }

                  Role? selectedRole = roleItem.where((role)=> role.id.toString() == newValue).toList().firstOrNull;
                  if(selectedRole ==null){
                    return;
                  }
                 // resultUserList = userlist.where((x)=>x["role_id"] == selectedRole.id).toList();
                  setState(() {
                    pickerSelectedValue = selectedRole.id.toString();
                     resultUserList = userlist.where((x)=>x["role_id"] == selectedRole.id).toList();
                  });

                  //showAlert(context,selectedRole.role + " was selected!");
                  datepicker(context);
                },
                items: roleItem.map<DropdownMenuItem<String>>((Role item) {
                  return DropdownMenuItem<String>(
                    value: item.id.toString(),
                    child: Text(item.role),
                  );
                }).toList(),
            ),
            Container(
              height: 400, // Set the desired height here
              child: ListView.builder(
                itemCount: resultUserList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserTile(
                    username:
                        resultUserList[index]['name'], // Replace with actual username from your list
                    image:
                        "1.png", // Replace with actual image path from your list
                    role: roleItem.firstWhere((role) => role.id == resultUserList[index]['role_id']).role??"", // Replace with actual role id from your list
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
