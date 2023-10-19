import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'main_service.dart';
import 'result_screen.dart';
import './utils/network.dart';

MainService mainService = MainService();

class ConvertScreen extends StatefulWidget {
  @override
  State<ConvertScreen> createState() => _ConvertScreen();
}

class _ConvertScreen extends State<ConvertScreen> {
  bool isLoading = true;
  String selctedValue = 'AUD';
  List<ResultScreen> resultScreen = [];

  CupertinoPicker iosCurrencyPicker() {
    return CupertinoPicker(
      itemExtent: 50,
      onSelectedItemChanged: (newValue) {
        convertCurrency(mainService.getCurrenciesList()[newValue]);
      },
      children: mainService
          .getCurrenciesList()
          .map((String value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }

  Center androidCurrencyPicker() {
    return Center(
      child: DropdownButton<String>(
        value: selctedValue,
        iconEnabledColor: Colors.white,
        dropdownColor: Colors.lightBlue,
        items: mainService
            .getCurrenciesList()
            .map(
              (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
            .toList(),
        onChanged: (newValue) {
          convertCurrency(newValue.toString());
        },
      ),
    );
  }

  Widget getCurrencyPicker() {
    if (Platform.isIOS) {
      return iosCurrencyPicker();
    } else {
      return androidCurrencyPicker();
    }
  }

  void convertCurrency(String selctedValue) async {
    setState(() {
      isLoading = true;
      resultScreen = [];
    });
    List<Map> tempResult = [];
    List<String> cryptoList = mainService.getCryptoList();
    for (var value in cryptoList) {
      Network networkService = Network(
          'https://rest.coinapi.io/v1/exchangerate/$value/$selctedValue');
      var resultCurrency = await networkService.get();
      tempResult.add(resultCurrency);
    }
    setState(() {
      selctedValue = selctedValue;
      isLoading = false;

      getResultScreen(selctedValue, tempResult, cryptoList);
    });
  }

  List<ResultScreen> getResultScreen(
      String selctedValue, List<Map> result, List<String> cryptoList) {
    for (var i = 0; i < cryptoList.length; i++) {
      String cryptoName = cryptoList[i];
      String resultNumber =
          isLoading ? '?' : result[i]['rate'].toStringAsFixed(0);
      resultScreen
          .add(ResultScreen('$cryptoName = $resultNumber $selctedValue'));
    }
    return resultScreen;
  }

  @override
  void initState() {
    convertCurrency('AUD');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: resultScreen),
          ),
          Container(
            height: 150,
            color: Colors.lightBlue,
            padding: EdgeInsets.only(bottom: 30.0),
            child: getCurrencyPicker(),
          )
        ],
      ),
    );
  }
}
