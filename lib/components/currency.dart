import 'package:intl/intl.dart';

class Currency {
  static String displayPriceFormat(int price) {
    final oCcy = NumberFormat("#,###", "en_US");
    return '${oCcy.format(price)}đ';
    // return price;
  }

  static String getSalePercent(int salePrice, int offPrice) {
    if (salePrice != offPrice) {
      var price = (salePrice - offPrice).abs() / salePrice;
      return '-${((price * 100).toInt().toString())}%';
    }
    return '';
  }
}