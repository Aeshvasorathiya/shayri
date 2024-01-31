import 'package:flutter/material.dart';
import 'package:shayri/data_1.dart';

import 'package:shayri/disp_1.dart';


class view extends StatefulWidget {
  int index;
  List name;
  List img;
  view(this.index,this.name, this.img);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List a = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.index) {
      case 0:
        a = data_class.life;
        break;
      case 1:
        a = data_class.life;
        break;
      case 2:
        a = data_class.pyar;
        break;
      case 3:
        a = data_class.anay;
        break;
      case 4:
        a = data_class.politics;
        break;
      case 5:
        a= data_class.Love;
        break;
      case 6:
        a = data_class.Remeber;
        break;
      case 7:
        a = data_class.sad;
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text("${widget.name[widget.index]}")),
      body: ListView.builder(
        itemCount: data_class.life.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(tileColor: Colors.red,
            leading: Image.asset("${widget.img[widget.index]}",height: 35),
            title: InkWell(onTap: () {

               Navigator.push(context, MaterialPageRoute(builder: (context) {
                return disp_1(index, a, data_class.name);
              },));
            },child: Text("${a[index]}",maxLines: 1,)),
          ));
        },
      ),
    );
  }
}
