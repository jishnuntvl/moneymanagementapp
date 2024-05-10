import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/db/category/category_db.dart';

import 'expense_cat_list.dart';
import 'incom_cate_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(labelColor: Colors.black,unselectedLabelColor: Colors.grey,
      controller: _tabController,tabs: [
        Tab(text: 'INCOME',),
        Tab(text: 'EXPENSE',)
      ]),Expanded(
        child: TabBarView(controller: _tabController,children: [
          IncomeCatList(),
          ExpenseCatList()
        ]),
      )
    ],);
  }
}