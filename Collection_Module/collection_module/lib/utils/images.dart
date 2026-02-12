class Images {
  static const String logo = 'assets/logo/logo.png';

  static const String logoPng = 'assets/logo/logo.png';
  static const String logolpeg = 'assets/logo/logo.jpeg';

  static String get user => 'user'.png;
  static String get splash => 'Splash'.png;

  static String get money => 'money'.png;
  static String get clock => 'clock'.png;
  static String get navigation => 'navi'.png;
  static String get carimage => 'carimage'.png;
  static String get dogimage => 'dog'.png;
  static String get rupees => 'money2'.png;
  static String get sos => 'sos'.png;
  static String get ubar => 'ubarcar'.png;
  static String get noficationimage1 => 'pillar_crane_code_composition'.png;
  static String get splashscreen => 'hellotaxi_mobile_screen'.png;

  static String get update => 'update'.png;
  static String get maintenance => 'maintenance'.png;
  static String get cart => 'cart'.png;
  static String get guest => 'guest'.png;

  static String get notification => 'notification'.svg;
  static String get search => 'search'.svg;
  static String get pet => 'group_pets'.svg;

  static String get chat => 'chat'.svg;

  static String get cancel => 'cancel'.svg;

  static String get lock => 'lock'.svg;

  static String get theme => 'theme'.svg;

  static String get keyPng => 'key'.png;
  static String get accountCircle => 'account_circle'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/images/$this.svg';
}
