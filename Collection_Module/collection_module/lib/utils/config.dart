enum Environment { DEV, UAT, PROD }

class Config {
  static Map<dynamic, dynamic> _config = _Config.debugConstants;
  //ANDROID KEY
  // static const String GoogleApiKey = 'AIzaSyAq4kppEUeT17-uW7Uly3te60kJDS2vxt8';

  //IOS KEY
  static const String GoogleApiKey = 'AIzaSyCh3c8qYAYu21XGM3aio-sZVpH6RXsh150';
  static const double appVersion = 1.0;

  static const String appName = 'Shining Dawn';
  static const String appVersionName = '1.0.0';
  static const String appVersionCode = '1';
  static const String appBuildNumber = '1';
  static const String appPackageName = 'com.shiningdawn.tnjewellers';

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.UAT:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get environment {
    return _config[_Config.environment];
  }

  static get baseUrl {
    return _config[_Config.baseUrl];
  }

  static get scopes {
    return _config[_Config.scopes];
  }
}

class _Config {
  static const String environment = 'dev';
  static const String baseUrl = 'http://192.168.1.23:90/';
  //'https://erp.shiningdawn.in/api/';
  //'https://tnjewellers.shiningdawn.in/api/';
  //'https://rk.shiningdawn.in/api/'
  //http://ssm.shiningdawn.in/api
  //https://api.srilakshmijewels.com/
  //https://erp.avsrsaravanaajewellery.com/api
  //'https://staging.shiningdawn.in/api/
  //http://192.168.1.23:90/

  static const List<String> scopes = <String>[
    'openid',
    'email',
    'byufuel-api',
    'profile',
    'offline_access'
  ];

  static Map<dynamic, dynamic> debugConstants = {
    environment: "dev",
    baseUrl: baseUrl,
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };

  static Map<dynamic, dynamic> stagingConstants = {
    environment: "uat",
    baseUrl: baseUrl,
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };

  static Map<dynamic, dynamic> prodConstants = {
    environment: "prod",
    baseUrl: baseUrl,
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };
}
// baseUrl: 'https://wholesale.shiningdawn.in/api/',
