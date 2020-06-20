import 'dart:convert';

import 'package:clicli_dark/api/post.dart';
import 'package:clicli_dark/instance.dart';
import 'package:clicli_dark/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  String name = '';
  String pwd = '';
  bool isDo = false;//是否请求登录状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        actions: <Widget>[
          FlatButton(
            child: Text('注册'),
            onPressed: () {
              launch('https://admin.clicli.me/register');
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 1,
              maxLengthEnforced: true,
              decoration: InputDecoration(labelText: '用户名'),
              onChanged: (v) {
                setState(() {
                  name = v;
                });
              },
            ),
            TextField(
              maxLines: 1,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: '密码',
              ),
              obscureText: true,
              onChanged: (v) {
                setState(() {
                  pwd = v;
                });
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('登录'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: (name.isEmpty || pwd.isEmpty) || isDo
                  ? null
                  : () async {
                      showSnackBar('登录中···');
                      setState(() {
                        isDo = true;
                      });
                      final res = jsonDecode(
                          (await login({'name': name, 'pwd': pwd})).data);

                      if (res['code'] != 200) {
                        showErrorSnackBar(res['msg']);
                        setState(() {
                          isDo = false;
                        });
                      } else {
                        setState(() {
                          isDo = false;
                        });
                        Instances.sp.setString('usertoken', res['token']);
                        Instances.sp
                            .setString('userinfo', jsonEncode(res['user']));
                        Instances.eventBus.fire(TriggerLogin());
                        Navigator.pop(context);
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}
