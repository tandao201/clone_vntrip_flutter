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
                                      subtitle: Text('ID thành viên: ${loginProv.accountInfo!.data!.memberId}'),
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
                                    'Thông tin cá nhân',
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
                                    'Thông tin đăng nhập',
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
                                          'Đăng xuất',
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
                                    'Tóm tắt phần thưởng', Container(),
                                    isBold: true, isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: itemList(
                                    'Hoàn tiền khả dụng',
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
                                    'Tổng tiền tích lũy',
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
                                    'Tổng tiền đã sử dụng',
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
                                    'Tổng tiền đã hết hạn',
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
                                    'Tổng tiền đang chờ',
                                    'Tiền đang chờ của quý khách sẽ khả dụng khi hoạt động nhận hoàn tiền được phê duyệt',
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
                                    'Xem hoạt động hoàn tiền và tiêu tiền',
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
                                child: itemList('Thẻ thành viên', Container(),
                                    isBold: true, isBlue: false),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey[200]!,
                              ),
                              Expanded(
                                flex: 1,
                                child: item2List(
                                    'Bạn không có thẻ thành viên',
                                    'Nếu bạn có thẻ thành viên, hãy thêm để kích hoạt',
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
                                    'Thêm thẻ khách hàng thân thiết',
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
                                          'Thiết lập người dùng',
                                          'Thiết lập ngôn ngữ, tiền tệ, địa chỉ và chương trình phần thưởng ưu tiên.',
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
                                  child: itemConfig('Ngôn ngữ', 'Việt Nam', 'Tiếng Anh')
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
                                child: itemConfig('Tiền tệ', 'VND', 'USD'),
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
                                      child: Text('Chương trình phần thưởng ưu tiên', style: TextStyle(fontSize: 15),),
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
                                          Text('Hoàn tiền Vntrip.vn'),
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
