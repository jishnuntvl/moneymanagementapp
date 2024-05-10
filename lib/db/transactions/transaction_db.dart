import 'package:flutter/foundation.dart';
import 'package:flutter_application_4/models/transaction/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TRANSACTION_DB_NAME='transaction-db';


abstract class TransactionDbFunctions{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>>getallTransaction();
  Future<void>deleteCategory(String transactionID);
}

class TransactionDb implements TransactionDbFunctions{
  TransactionDb._internal();

  static TransactionDb instance=TransactionDb._internal();

  factory TransactionDb(){
    return instance;
  }


  ValueNotifier<List<TransactionModel>>transactionListNotifier=ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel obj)async {
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id,obj);
  }

  Future<void>refresh()async{
    final _list=await getallTransaction();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getallTransaction()async {
    final _db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }
  
  @override
  Future<void> deleteCategory(String transactionID)async {
    final _transactionyDb=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionyDb.delete(transactionID);
    refresh();
  }

}