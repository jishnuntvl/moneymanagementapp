import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/category/category_db.dart';
import 'package:flutter_application_4/db/transactions/transaction_db.dart';
import 'package:flutter_application_4/models/category/category_model.dart';
import 'package:flutter_application_4/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName='add_transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {

  // DateTime? _selecteddate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryid;

  final _purposeController=TextEditingController();
  final _amountController=TextEditingController();
  final _dateController=TextEditingController();

  @override
  void initState() {
    _selectedCategoryType=CategoryType.income;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        TextFormField(controller: _purposeController,decoration: InputDecoration(hintText: 'Purpose'),),
        TextFormField(controller: _amountController,keyboardType: TextInputType.number,decoration: InputDecoration(hintText: 'Amount'),),
        TextFormField(controller: _dateController,decoration: InputDecoration(hintText: 'Date'),),
        // TextButton.icon(onPressed: ()async{
        //   final _selecteddate= await (context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(Duration(days: 30)), lastDate: DateTime.now());
        //   if(_selecteddate==null){
        //     return;
        //   }else{
        //     print(_selecteddate.toString());
        //   }
        // }, icon: Icon(Icons.calendar_today), label: Text('Select date')),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Radio(value: CategoryType.income, groupValue: _selectedCategoryType, onChanged: (newValue){
                  setState(() {
                    _selectedCategoryType=CategoryType.income;
                    _categoryid=null;
                  });
                }),
                Text('Income'),
              ],
            ),
            Row(
              children: [
                Radio(value: CategoryType.expense, groupValue: _selectedCategoryType, onChanged: (newValue){
                setState(() {
                  _selectedCategoryType=CategoryType.expense;
                  _categoryid=null;
                });
                  
                }),
                Text('Expense'),
              ],
            ),
          ],
        ),
        DropdownButton(
          hint: Text('Select Category'),value: _categoryid,
          items: (_selectedCategoryType==CategoryType.income? CategoryDb.instance.incomeCategoryListListener : CategoryDb.instance.expenseCategoryListListener).value.map((e){
          return DropdownMenuItem(child: Text(e.name),value: e.id,onTap: (){_selectedCategoryModel=e;},);
        }).toList(), 
        onChanged: (selectedvalue){
          setState(() {
            _categoryid=selectedvalue;
          });
          
        }),
        ElevatedButton.icon(onPressed: (){addTransaction();}, icon: Icon(Icons.check), label: Text('Submit'))
      ]),
    ),));
  }
  Future<void>addTransaction()async{
      final _purpose=_purposeController.text;
      final _amount=_amountController.text;
      final _date=_dateController.text;

      if(_purpose.isEmpty || _amount.isEmpty || _date.isEmpty){
        return;
      }
      if(_categoryid==null){
        return;
      }
      final _parseAmount=double.tryParse(_amount);
      if(_parseAmount==null){
        return;
      }
      if(_selectedCategoryModel==null){
        return;
      }
      final _model=TransactionModel(purpose: _purpose, amount: _parseAmount, date: _date, type: _selectedCategoryType!, category: _selectedCategoryModel!);
      await TransactionDb.instance.addTransaction(_model);
      Navigator.of(context).pop();
      TransactionDb.instance.refresh();
  }
}