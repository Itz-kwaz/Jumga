class ApiRoutes {

  static  String fxRates(String toCurrency) {
    return 'https://api.flutterwave.com/v3/rates?from=USD&to=$toCurrency&amount=1';
  }

}