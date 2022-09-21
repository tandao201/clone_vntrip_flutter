import 'package:clone_vntrip/models/login/request.dart';
import 'package:clone_vntrip/providers/login_providers.dart';
import 'package:clone_vntrip/providers/validation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/colors.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPass = true;
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void clickShowPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }


  @override
  Widget build(BuildContext context) {
    final validService = Provider.of<ValidInput>(context);
    final loginService = Provider.of<LoginProvider>(context);

    void clickLoginButton(BuildContext context, RequestLogin requestLogin) async {
      validService.checkInput(requestLogin);
      print("username: ${usernameController.text}");
      print("usernameState: ${validService.isEmptyUsername} ${validService.isValidUsername}");
      print("passState : ${validService.isEmptyPass} ${validService.isValidPassword}");
      print("userError: ${validService.error}");
      hideKeyboard();
      if (validService.error.isEmpty) {
        // try {
          await loginService.login(requestLogin);
          if (loginService.responseLogin != null) {
            Navigator.pushReplacementNamed(context, Home.routeName, arguments: {'response' : loginService.responseLogin!});
          } else {

          }
        // } catch (ex) {
        //   print('Ex from login page: ${ex.toString()}');
        // }
      }
    }
    // print("username: $isEmptyUsername");

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        title: const Text(
          'Đăng nhập',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: AppColor.grayHintText,
            height: 2,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: InkWell(
          onTap: hideKeyboard,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Consumer<ValidInput> (
              builder: (context, validProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        style: const TextStyle(fontSize: 13),
                        controller: usernameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: validProvider.isEmptyUsername || !validProvider.isValidUsername
                                  ? const BorderSide(color: Colors.red, width: 1)
                                  : BorderSide(color: AppColor.grayHintText, width: 1),
                              borderRadius: BorderRadius.circular(9)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.lightBlue, width: 1),
                              borderRadius: BorderRadius.circular(9)),
                          hintText: 'Nhập số điện thoại hoặc email',
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                          child: TextField(
                            controller: passwordController,
                            obscureText: isShowPass,
                            style: const TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: validProvider.isEmptyPass || !validProvider.isValidPassword
                                      ? const BorderSide(color: Colors.red, width: 1)
                                      : BorderSide(
                                      color: AppColor.grayHintText, width: 1),
                                  borderRadius: BorderRadius.circular(9)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.lightBlue, width: 1),
                                  borderRadius: BorderRadius.circular(9)),
                              hintText: 'Mật khẩu',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: clickShowPass,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                            child: isShowPass ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                          ),
                        )
                      ],
                    ),
                    if (validProvider.error.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Text(
                          validProvider.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: const Text(
                        'Quên mật khẩu?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.orangeMain),
                          onPressed: () => clickLoginButton(
                              context,
                              RequestLogin(
                                  phone: usernameController.text,
                                  password: passwordController.text)),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text('ĐĂNG NHẬP'),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              color: AppColor.grayHintText,
                              height: 1,
                            )),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            'Hoặc',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              color: AppColor.grayHintText,
                              height: 1,
                            )),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: AppColor.grayHintText)),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        label: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Đăng nhập bằng Facebook',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: AppColor.grayHintText)),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        label: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Đăng nhập bằng Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.sports_golf_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: AppColor.grayHintText)),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        label: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Đăng nhập bằng Apple',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.apple,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Bạn chưa có tài khoản?'),
                        const SizedBox(
                          width: 5,
                          height: 0,
                        ),
                        Text(
                          'Đăng ký',
                          style: TextStyle(color: AppColor.orangeMain),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Bạn là khách hàng doanh nghiệp?'),
                        const SizedBox(
                          width: 5,
                          height: 0,
                        ),
                        Text(
                          'Đăng nhập',
                          style: TextStyle(color: AppColor.orangeMain),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
