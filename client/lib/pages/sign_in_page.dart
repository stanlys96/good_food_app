import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../data/api/apiService.dart';
import '../widgets/dialog.dart';

class SignInPage extends StatefulWidget {
  static final routeName = '/signIn';
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool hidePassword = true;
  String _email = '';
  String _password = '';

  signIn() async {
    ApiService().login(_email, _password).then((val) {
      final parsed = jsonDecode(val.toString()) as Map;
      if (parsed['message'] == 'Username or password is incorrect!') {
        showError(parsed['message'].toString(), context);
      } else {
        SharedPreferences.getInstance().then((val) {
          val.setString('userEmail', parsed['email']);
          val.setString('userFullName', parsed['full_name']);
          Navigator.pushNamed(context, '/main', arguments: {
            "fullName": parsed['full_name'],
            "email": parsed['email']
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(248, 247, 252, 1),
        titleSpacing: 10.0,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined),
              Text(
                ' Home',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(248, 247, 252, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/good_food.png',
                width: 150.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 5.0,
                  bottom: 10.0,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 5.0,
                    top: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.1),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Sign in to your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Form(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24.0,
                                bottom: 12.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email ID*',
                                    style: TextStyle(
                                      color: Color.fromRGBO(219, 219, 219, 1),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (val) {
                                            setState(() {
                                              _email = val;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(0.0),
                                        constraints: BoxConstraints(
                                          maxHeight: 30.0,
                                          maxWidth: 30.0,
                                        ),
                                        onPressed: () {},
                                        icon: FaIcon(FontAwesomeIcons.envelope),
                                        color: Color.fromRGBO(253, 124, 24, 1),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 5.0,
                                    thickness: 2.0,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password*',
                                  style: TextStyle(
                                    color: Color.fromRGBO(219, 219, 219, 1),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: hidePassword,
                                        onChanged: (val) {
                                          setState(() {
                                            _password = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0.0),
                                      constraints: BoxConstraints(
                                        maxHeight: 30.0,
                                        maxWidth: 30.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: FaIcon(
                                        !hidePassword
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                      ),
                                      color: Color.fromRGBO(253, 124, 24, 1),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 2.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerRight,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Forgot your Password?',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: signIn,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(
                                  color: Color.fromRGBO(253, 124, 24, 1),
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(253, 124, 24, 1),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: Text(
                          'Or Login using social media',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              Icons.facebook,
                              color: Color.fromRGBO(46, 73, 116, 1),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.book,
                              color: Color.fromRGBO(23, 165, 249, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Register Now',
                      style: TextStyle(
                        color: Color.fromRGBO(253, 124, 24, 1),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
