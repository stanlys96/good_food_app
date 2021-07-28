import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/api/apiService.dart';

class SignUpPage extends StatefulWidget {
  static final routeName = '/signUp';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // For component
  bool hidePassword = true;
  bool isChecked = false;
  String _fullName = '';
  String _email = '';
  String _password = '';
  String token = '';

  signUp() async {
    ApiService().register(_fullName, _email, _password).then((val) {
      if (val != null) {
        Navigator.pushNamed(context, '/signIn');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(248, 247, 252, 1),
        backgroundColor: Theme.of(context).primaryColor,
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
      backgroundColor: Theme.of(context).primaryColor,
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
                    color: Theme.of(context).accentColor,
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
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
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
                                    'Full Name*',
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
                                              _fullName = val;
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
                                        icon: FaIcon(FontAwesomeIcons.user),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
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
                                        maxHeight: 35.0,
                                        maxWidth: 35.0,
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
                        padding: EdgeInsets.symmetric(
                          vertical: 12.5,
                        ),
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20.0,
                              width: 16.0,
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor:
                                      Color.fromRGBO(219, 219, 219, 1),
                                ),
                                child: Checkbox(
                                  activeColor: Color.fromRGBO(219, 219, 219, 1),
                                  onChanged: (val) {
                                    setState(() {
                                      isChecked = !isChecked;
                                    });
                                  },
                                  value: isChecked,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'I have read and agreed to ',
                              style: TextStyle(
                                color: Color.fromRGBO(219, 219, 219, 1),
                                fontWeight: FontWeight.w900,
                                fontSize: 13.0,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                  color: Color.fromRGBO(253, 124, 24, 1),
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: signUp,
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
                            'Register',
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
                          'Or Register using social media',
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
                    'Already have an account?',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(0.0, 0.0),
                      padding: EdgeInsets.zero,
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromRGBO(253, 124, 24, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signIn');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
