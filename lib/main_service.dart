class MainService {
  final List<String> _currenciesList = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
  ];

  final List<String> _cryptoList = [
    'BTC',
    'ETH',
    'LTC',
  ];

  List<String> getCryptoList() {
    return _cryptoList;
  }

  List<String> getCurrenciesList() {
    return _currenciesList;
  }
}
