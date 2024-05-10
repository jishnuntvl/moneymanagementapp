import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/db/category/category_db.dart';
import 'package:flutter_application_4/db/transactions/transaction_db.dart';
import 'package:flutter_application_4/models/category/category_model.dart';

import '../../models/transaction/transaction_model.dart';

class ScreenTransation extends StatelessWidget {
  const ScreenTransation({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(valueListenable: TransactionDb.instance.transactionListNotifier, 
    builder: (BuildContext ctx, List<TransactionModel>newList, Widget? _){
      return ListView.separated(padding: EdgeInsets.all(5),itemBuilder: (ctx,index){
        final _value=newList[index];
      return Dismissible(
        confirmDismiss: (direction)async{
          
          return true;
        },
        key: Key(_value.id!),
        child: Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: _value.type==CategoryType.income ? Colors.green:Colors.red,radius: 50,child: Text(_value.date)),
            title: Text('Rs ${_value.amount}'),
            subtitle: Text(_value.category.name),
            trailing: IconButton(onPressed: (){
              TransactionDb.instance.deleteCategory(_value.id!);
            },icon: Icon(Icons.delete)
          ),
        ),
      ));
    },
    separatorBuilder: (ctx,index){
        return SizedBox(height: 5,);
    },
    itemCount: newList.length,);
    });
  }
}