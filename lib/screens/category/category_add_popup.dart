import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/category/category_db.dart';
import 'package:flutter_application_4/models/category/category_model.dart';

ValueNotifier<CategoryType>selectedCategoryNoti=ValueNotifier(CategoryType.income);

Future<void>showCategoryAddPopup(BuildContext context)async{
  final _nameController=TextEditingController();

  showDialog(context: context,builder: (ctx){
    return SimpleDialog(title: Text('Add category'),
    children: [
      TextFormField(controller: _nameController,decoration: InputDecoration(hintText: 'Category name',border: OutlineInputBorder()),),
      Padding(padding: const EdgeInsets.all(8.0),child: Row(children: [
          RadioButton(title: 'Income', type: CategoryType.income),
          RadioButton(title: 'Expense', type: CategoryType.expense)
      ],)),
      ElevatedButton(onPressed: (){
        final _name=_nameController.text;
        if(_name.isEmpty)
        {
          return;
        }
        final _type=selectedCategoryNoti.value;
        final _category=CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(), name: _name, type: _type);

        CategoryDb().insertCategory(_category);
        Navigator.of(ctx).pop();

      }, child: Text('Add'))
    ],);
  });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  //final CategoryType selectedType;
  const RadioButton({super.key,required this.title,required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(valueListenable: selectedCategoryNoti, builder: (
          BuildContext ctx, CategoryType newCategory, Widget? _)
        {
          return Radio<CategoryType>(value: type, groupValue: selectedCategoryNoti.value, onChanged: ((value) {
          if(value==null){
            return;
          }
            selectedCategoryNoti.value=value;
            selectedCategoryNoti.notifyListeners();
        }));
        }),
        Text(title),

      ],
    );
  }
}