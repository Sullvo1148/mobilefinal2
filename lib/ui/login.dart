import 'package:flutter/material.dart';
import '../models/user.dart';
import './home.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
/////////////////////////////////variance//////////////////////////////////////////////////
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();
  UserProvider userProvider = UserProvider();
  List<User> currentUsers = List();
/////////////////////////////////variance//////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    userProvider.open('member.db').then((r) {
      print("open success");
      getUsers();
    });
  }

  void getUsers() {
    userProvider.getUsers().then((r) {
      setState(() {
        currentUsers = r;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
      ),
//////////////////////////////////////////////////////////////////////////////////////////////
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
//////////////////////////////////////////////////////////////////////////////////////////////
              Image.network(
                "https://cna-sg-res.cloudinary.com/image/upload/q_auto,f_auto/image/10717974/16x9/991/557/90bcf80c4033f836b1fa0fcbd78d670f/Sw/with-a-ban-on-political-activities-still-in-place-thai-junta-leader-prayut-chan-o-cha-has-spent-months-positioning-himself-for-a-potential-run-at-the-next-election-1536827800881-2.jpg",
                height: 200,
              ),
//////////////////////////////////////////////////////////////////////////////////////////////
              TextFormField(
                controller: userid,
                decoration: InputDecoration(
                  labelText: "User Id",
                ),
                validator: (value) {
                  if (value.isEmpty) return "Username is required";
                },
              ),
//////////////////////////////////////////////////////////////////////////////////////////////
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) return "Password is required";
                },
              ),
//////////////////////////////////////////////////////////////////////////////////////////////
              Row(
                //เป็นปุ่มสุดขอบหน้าจอ
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      child: Text("sign in"),
                      onPressed: () {
                        bool cleck = false;
                        if (_formkey.currentState.validate()) {
                          for (int i = 0; i < currentUsers.length; i++) {
                            if (userid.text == currentUsers[i].userid &&
                                password.text == currentUsers[i].password) {
                              cleck = true;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(user: currentUsers[i]),
                                ),
                              );
                            }
                          }
                          if (!cleck) {
                            Toast.show("Invalid user or password", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        }
                        else {
                          Toast.show("Please fill out this form", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                  ),
                ],
              ),
//////////////////////////////////////////////////////////////////////////////////////////////
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text("Register new account"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  )
                ],
              )
//////////////////////////////////////////////////////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
