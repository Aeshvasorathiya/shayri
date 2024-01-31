import 'package:flutter/material.dart';
import 'package:shayri/data_1.dart';
import 'package:shayri/disp_1.dart';
import 'package:shayri/second%20.dart';


void main() {
  runApp(MaterialApp(
    home: home_page(),
    debugShowCheckedModeBanner: false,
  ));
}

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  List<bool> temp =List.filled(data_class.name.length, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Love Shayari"),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Icon(Icons.share),
                    ),
                    Icon(Icons.menu)
                  ],
                )
              ],
            )),
        body: ListView.builder(
          itemCount: data_class.name.length,
          itemBuilder: (context, index) {
            return Card(

                child: GestureDetector(
                  onTapUp: (details){
                    print("hello");
                    temp[index]=false;
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return view();
                    // }));
                    setState(() {

                    });
                  },
                  onTapCancel: (){
                    print("good morning");
                    temp[index]=false;
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return
                    // }));
                    setState(() {

                    });
                  },
                  onTapDown: (details){
                    print("good");
                    temp[index]=true;
                    setState(() {

                    });
                  },
                 child:   ListTile(
                   tileColor: (temp[index])?Colors.pink:null,
                     trailing: (temp[index])?Icon(Icons.arrow_forward_ios):null,
                     // title:Text("${data_class.lnt[index]}"),

                     onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return view(index, data_class.name, data_class.img);

                      },));
                    },
            title: Text("${data_class.name[index]}"),
                        leading: CircleAvatar(backgroundImage: AssetImage("${data_class.img[index]}"),) ,
                 ),
            ),
            );
          },
        ));
  }
}
