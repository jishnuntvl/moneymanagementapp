import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/db/category/category_db.dart';

import '../../models/category/category_model.dart';

class ExpenseCatList extends StatelessWidget {
  const ExpenseCatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDb().expenseCategoryListListener, builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _){
      return ListView.separated(itemBuilder: (ctx,index){
        final category=newlist[index];
        return Card(
          child: ListTile(
            title: Text(category.name),
            trailing: IconButton(onPressed: (){
              CategoryDb.instance.deleteCategory(category.id);
            },icon: Icon(Icons.delete),),
          ),
        );
    }
    , separatorBuilder: (ctx,index){
        return SizedBox(height: 10,);
    },
     itemCount: newlist.length);
    });
  }
}