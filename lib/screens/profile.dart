import 'package:clone_vntrip/components/currency.dart';
import 'package:clone_vntrip/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/login_providers.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final loginProv = Provider.of<LoginProvider>(context);

    if (loginProv.accountInfo == null && (loginProv.authToken != null || loginProv.authToken!.isEmpty ) ) {
      loginProv.detailAccount();
      loginProv.getProfileUser();
    }

    if (loginProv.loyalties == null ) {
      loginProv.getLoyalties();
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      child: const Text(
                        'Dashboard',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _launchURL("tel://0963266688"),
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ), //appBar
              ),
              loginProv.accountInfo == null ?
              CircularProgressIndicator() :
              Expanded(
                child: Container(
                  width: widthScreen,
                  color: Colors.grey[200]!,
                  child: SingleChildScrollView(
                    // reverse: true,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(7),
                          width: widthScreen,
                          height: heightScreen / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: ListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: 0),
                                      minLeadingWidth: 0,
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      leading: Image.network(loginProv.accountInfo!.data!.levelImage!),
                                      title: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: loginProv.accountInfo!.data!.levelName,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black)),
                                                const TextSpan(
                                                    text: ' | Cashback: ',
                                                    style: TextStyle(
                                                        color: Colors.grey))
                                              ])),
                                          Text(
                                            Currency.displayPriceFormat(loginProv.accountInfo!.data!.availablePoint!),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          )
                                        ],
                                      ),
                                      subtitle: Text('ID th??nh vi??n: ${loginProv.accountInfo!.data!.memberId}'),
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: ListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: 0),
                                      minLeadingWidth: 0,
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      leading: const Icon(Icons.access_time),
                                      title: Text(
                                        loginProv.accountInfo!.data!.userName!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text("aksjdk"),
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'Th??ng tin c?? nh??n',
                                    const Icon(Icons.arrow_forward_ios,
                                        size: 20, color: Colors.grey),
                                    isBlue: true,
                                    isBold: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'Th??ng tin ????ng nh???p',
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    isBlue: true,
                                    isBold: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      loginProv.clearData();
                                      Navigator.pushNamed(
                                          context, Login.routeName);
                                    },
                                    child: Container(
                                      margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Text(
                                          '????ng xu???t',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(7),
                          width: widthScreen,
                          height: heightScreen,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'T??m t???t ph???n th?????ng', Container(),
                                    isBold: true, isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'Ho??n ti???n kh??? d???ng',
                                    Text(
                                      Currency.displayPriceFormat(loginProv.accountInfo!.data!.availablePoint!),
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    isBold: false,
                                    isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'T???ng ti???n t??ch l??y',
                                    Text(
                                        Currency.displayPriceFormat(loginProv.accountInfo!.data!.totalGainedPoint!)
                                    ),
                                    isBold: false,
                                    isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'T???ng ti???n ???? s??? d???ng',
                                    Text(
                                      Currency.displayPriceFormat(loginProv.accountInfo!.data!.usedPoint!),
                                    ),
                                    isBold: false,
                                    isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'T???ng ti???n ???? h???t h???n',
                                    Text(
                                      Currency.displayPriceFormat(loginProv.accountInfo!.data!.expiredPoint!),
                                    ),
                                    isBold: false,
                                    isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 2,
                                child: item2List(
                                    'T???ng ti???n ??ang ch???',
                                    'Ti???n ??ang ch??? c???a qu?? kh??ch s??? kh??? d???ng khi ho???t ?????ng nh???n ho??n ti???n ???????c ph?? duy???t',
                                    Text(
                                      Currency.displayPriceFormat(loginProv.accountInfo!.data!.pendingPoint!),
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.orange),
                                    ),
                                    isItalics: true),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'Xem ho???t ?????ng ho??n ti???n v?? ti??u ti???n',
                                    const Icon(Icons.arrow_forward_ios,
                                        size: 20, color: Colors.grey),
                                    isBold: false,
                                    isBlue: true),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList('Th??? th??nh vi??n', Container(),
                                    isBold: true, isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: item2List(
                                    'B???n kh??ng c?? th??? th??nh vi??n',
                                    'N???u b???n c?? th??? th??nh vi??n, h??y th??m ????? k??ch ho???t',
                                    Container(),
                                    isItalics: true),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'Th??m th??? kh??ch h??ng th??n thi???t',
                                    Icon(Icons.arrow_forward_ios,
                                        size: 20, color: Colors.grey),
                                    isBold: false,
                                    isBlue: true),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(7),
                          width: widthScreen,
                          height: heightScreen / 1.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Expanded(
                                      flex: 2,
                                      child: item2List(
                                          'Thi???t l???p ng?????i d??ng',
                                          'Thi???t l???p ng??n ng???, ti???n t???, ?????a ch??? v?? ch????ng tr??nh ph???n th?????ng ??u ti??n.',
                                          Container(),
                                          isItalics: true),
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: itemConfig('Ng??n ng???', 'Vi???t Nam', 'Ti???ng Anh')
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemConfig('Ti???n t???', 'VND', 'USD'),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text('Ch????ng tr??nh ph???n th?????ng ??u ti??n', style: TextStyle(fontSize: 15),),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.circular(3)
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Ho??n ti???n Vntrip.vn'),
                                          Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemConfig(String title, String item1, String item2) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey),),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: Colors.grey)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.ac_unit_outlined, size: 13,),
                      SizedBox(width: 5,),
                      Text(item1),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Align(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: Colors.grey)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.ac_unit_outlined, size: 13,),
                      SizedBox(width: 5,),
                      Text(item2),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemList(String title, Widget rightWidget,
      {bool? isBlue, bool? isBold}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: isBlue!
                    ? Colors.blue
                    : isBold!
                        ? Colors.black
                        : Colors.grey,
                fontSize: 15,
                fontWeight: isBold! ? FontWeight.bold : FontWeight.normal),
          ),
          rightWidget,
        ],
      ),
    );
  }

  Widget item2List(String title, String subtitle, Widget rightWidget,
      {bool? isItalics}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              rightWidget,
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontStyle: isItalics! ? FontStyle.italic : FontStyle.normal,
                fontSize: 12,
              color: Colors.grey
            ),
          )
        ],
      ),
    );
  }
}
