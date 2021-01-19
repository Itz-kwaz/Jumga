import 'package:flutter/material.dart';
import 'package:jumga/Core/routes/routes.dart';
import '../../constants.dart';

class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.subtitle1.copyWith(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed(Routes.addItemScreen);
        },
        child: Icon(Icons.add,
        color: Colors.white,),
      ),
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),
          Expanded(
            child: GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                        children: [
                          Text('Hello',
                          style: textStyle,),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text('Give the secret',
                          style: TextStyle(
                            
                          ),)

                        ],
                  ),
                );
              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),

            ),
          )
        ],
      )
    );
  }
}
