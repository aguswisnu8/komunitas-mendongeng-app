commingDay(String dateTest) {
  DateTime now = DateTime.now();
  String dateNow = '${now.year}-' +
      now.month.toString().padLeft(2, '0') +
      '-' +
      now.day.toString().padLeft(2, '0');
  dateNow = '2022-03-03';
  if (dateTest.compareTo(dateNow) >= 1) {
    return true;
  } else {
    return false;
  }
  // return dateNow;
}

pastDay(String dateTest) {
  DateTime now = DateTime.now();
  String dateNow = '${now.year}-' +
      now.month.toString().padLeft(2, '0') +
      '-' +
      now.day.toString().padLeft(2, '0');
  dateNow = '2022-03-03';
  if (dateTest.compareTo(dateNow) == -1) {
    return true;
  } else {
    return false;
  }
  // return dateNow;
}

cekImage(String imageUrl) {
  String defUrl = 'http://192.168.413.239/storage/mendongengss/';
  if (imageUrl.length > defUrl.length) {
    return true;
  } else {
    return false;
  }
}

cekPengalaman(String exp) {
  switch (exp) {
    case '1':
      return 'tidak ada';
    case '2':
      return 'pemula';
    case '3':
      return 'sedang';
    case '4':
      return 'menengah';
    case '5':
      return 'profesional';
    default:
      return 'tidak ada';
  }
}


