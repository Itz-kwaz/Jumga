import 'package:flutterwave/utils/flutterwave_currency.dart';

class ApiRoutes {

  static   String fxRatesUrl(String toCurrency) {
    return 'https://api.flutterwave.com/v3/rates?from=USD&to=$toCurrency&amount=1';
  }

  static  String branchCodeUrl(int id) {
    return 'https://api.flutterwave.com/v3/banks/$id/branches';
  }

  static  const String transfersUrl ='https://api.flutterwave.com/v3/transfers';

  static String banksUrl(String currency) {
    String parameter;
    switch(currency) {
      case FlutterwaveCurrency.KES:
        parameter = 'KE';
        break;
      case FlutterwaveCurrency.GHS:
        parameter = 'GH';
        break;
      default:
        parameter = 'NG';
        break;

    }
    return 'https://api.flutterwave.com/v3/banks/$parameter';
  }

}