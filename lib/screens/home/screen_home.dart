import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/screens/add_transaction/screen_add_transation.dart';
import 'package:flutter_application_4/screens/category/category_add_popup.dart';
import 'package:flutter_application_4/screens/category/screen_category.dart';
import 'package:flutter_application_4/screens/transaction/screen_transation.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  int _selectedindex=0;

  final _pages=[
    ScreenTransation(),
    ScreenCategory()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[100],appBar: AppBar(title: Text('Maney Manager'),centerTitle: true,),body: _pages[_selectedindex],
    floatingActionButton: FloatingActionButton(onPressed: (){
      if(_selectedindex==0){
        print('Transs');
        Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
      }else{
        print('cate');
        showCategoryAddPopup(context);
        // final _sample=CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(),name: 'travel',type: CategoryType.expense);
        // CategoryDb().insertCategory(_sample);
      }
    },child: Icon(Icons.add),)
    ,bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedindex,
      onTap: (newindex){
        setState(() {
          _selectedindex=newindex;
        });
      },
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.money_sharp),label: 'Transactions'),
      BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category')
    ]),);
  }
}