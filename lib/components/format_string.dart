class FormatString {
  static getFirstName(String name) {
    return name.split(RegExp(r"\s\b|\b\s"))[0];
  }

  static getLastName(String name) {
    List<String> listName = name.split(RegExp(r"\s\b|\b\s"));
    return listName.last;
  }

  static String getSubAndName(String name) {
    List<String> listName = name.split(RegExp(r"\s\b|\b\s"));
    if (listName.length==1) {
      return '';
    }
    String rs = '';
    for (int i=0 ; i<listName.length ; i++) {
      if (i>0 ) {
        rs += listName[i];
      }
    }
    return rs;
  }

  static getSubName(String name) {
    List<String> listName = name.split(RegExp(r"\s\b|\b\s"))[0] as List<String>;
    if (listName.length==1) {
      return '';
    }
    String rs = '';
    for (int i=0 ; i<listName.length ; i++) {
      if (i>0 && i<listName.length-1) {
        rs = '$rs ${listName[i]}';
      }
    }
    return rs;
  }
}