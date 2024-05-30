import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/api/api_firebase_gen_functions.dart';

import 'package:flutter/material.dart';

class AddressListProvider with ChangeNotifier {
  FirebaseFunctionsAPI firebaseFunctions = FirebaseFunctionsAPI();
  late Stream<List<dynamic>> _addressStream;

  Stream<List<dynamic>> get addressList => _addressStream;

  void fetchAddress(String user) {
    _addressStream = firebaseFunctions.getAddressList(user);
    notifyListeners();
  }

  void addAddress(String user, String address) async {
    await firebaseFunctions.addAddress(user, address);
    notifyListeners();
  }

  // void addAddress(Address address) {
  //   _addressList.add(address);
  //   notifyListeners();
  // }

  // void removeAddress(Address address) {
  //   _addressList.remove(address);
  //   notifyListeners();
  // }
}
