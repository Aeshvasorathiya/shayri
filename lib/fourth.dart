import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayri/data_1.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

// import 'package:share_plus/share_plus.dart';
// import 'package:shayari/dataa.dart';
// import 'package:shyari_app/dataa.dart';

class edit_page extends StatefulWidget {
  int index;
  List a;
  int ind1;
  int ind2;

  edit_page(this.a, this.index, this.ind1, this.ind2);

  // List emoji=[
  //
  // ];

  @override
  State<edit_page> createState() => _edit_pageState();
}

class _edit_pageState extends State<edit_page> {

  WidgetsToImageController controlle = WidgetsToImageController();

  Uint8List? bytes;
  double b = 20;
  Color col = Colors.red;
  bool clr_sts = true;
  int pos = 0;
  Color font_color = Colors.black;

  String font_style = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prmison();
  }
  prmison() async {
    var status = await Permission.storage.status;
    if(status.isDenied){
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
    print(status);

  }

  // bool clr_rnd = true;
  PageController? controller;

  @override
  Widget build(BuildContext context) {
    double scr_size = MediaQuery.of(context).size.height;
    double status_bar = MediaQuery.of(context).padding.top;
    double app_bar = kToolbarHeight;
    double hight = scr_size - app_bar - status_bar - 505;
    double size = scr_size - status_bar - app_bar - 10;

    return Scaffold(
      appBar: AppBar(
          title: Text("photo pe sharyi likhe"), backgroundColor: Colors.green),
      body: Column(children: [
        Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 50, right: 10, left: 10),
              child: WidgetsToImage(
                  child: Container(
                  decoration: BoxDecoration(
                      color: (clr_sts == true) ? col : null,
                      gradient: (clr_sts == false)
                          ? LinearGradient(colors: [
                        data_class.clr[pos],
                        data_class.clr[pos + 1],
                      ])
                          : null),
                  width: double.infinity,
                  // decoration: BoxDecoration,
                  height: 400,
                  child: Center(
                    child: Text("${widget.a[widget.index]}",
                        style: TextStyle(
                            fontSize: b,
                            color: font_color,
                            fontFamily: "$font_style")),
                  )), controller: controlle)
            )),
        SizedBox(height: 180),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.black87,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                top: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white, border: Border.all(width: 2)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                clr_sts = false;
                                data_class.clr.shuffle();
                                setState(() {});
                              },
                              child: Image.asset(
                                  height: 40, "myasset/image/reload.png")),
                          // SizedBox(width: 40),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: size,
                                    color: Colors.transparent,
                                    child: GridView.builder(
                                      itemCount: data_class.clr.length - 1,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            clr_sts = false;
                                            pos = index;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                                "${widget.a[widget.index]}",
                                                style: TextStyle(fontSize: 15),
                                                maxLines: 1),
                                            // width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                  data_class.clr[index],
                                                  data_class.clr[index + 1]
                                                ])),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              height: 40,
                              "myasset/image/expand.png",
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: hight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: GridView.builder(
                                      itemCount: data_class.clr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 8,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            col = data_class.clr[index];
                                            clr_sts = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            color: data_class.clr[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(alignment: Alignment.topRight,
                                  height: 50,
                                  child: InkWell(onTap: () {
                                    Navigator.pop(context);
                                  },child: Image.asset("myasset/image/close.png")),
                                )],
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Background",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: hight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      itemCount: data_class.clr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 8,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemBuilder:(context, index) {
                                        return InkWell(
                                          onTap: () {
                                            font_color = data_class.clr[index];
                                            setState(() {});
                                          },
                                          child: Container(
                                            child: Text(
                                              "${widget.a[widget.index]}",
                                              style: TextStyle(
                                                  color: data_class.clr[index]),
                                            ),
                                            color: data_class.clr[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(alignment: Alignment.topRight,
                                    height: 50,
                                    child: InkWell(onTap: () {
                                      Navigator.pop(context);
                                    },child: Image.asset("myasset/image/close.png")),
                                  )],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Text Color",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        bytes = await controlle.capture();

                        var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/aaa";

                        Directory dir = Directory(path);
                        if(!await dir.exists())
                          {
                            dir.create();
                          }

                        String img_name = "${Random().nextInt(1000)}myimg.png";

                        File file = File("${dir.path}/${img_name}");
                        file.writeAsBytes(bytes!);
                        Share.shareFiles(['${file.path}'], text: 'Great picture');
                        },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Share",
                            style:
                                TextStyle
                                  (color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: hight,
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    font_style = "one";
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 75,
                                                    color: Colors.grey,
                                                    child: Text("shayri",
                                                        style: TextStyle(
                                                            fontFamily: "one",
                                                            fontSize: 15)),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    font_style = "two";
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 75,
                                                    color: Colors.grey,
                                                    child: Text("two",
                                                        style: TextStyle(
                                                            fontFamily: "two",
                                                            fontSize: 15)),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    font_style = "three";
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 75,
                                                    color: Colors.grey,
                                                    child: Text("three",
                                                        style: TextStyle(
                                                            fontFamily: "three",
                                                            fontSize: 15)),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    font_style = "four";
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 75,
                                                    color: Colors.grey,
                                                    child: Text("four",
                                                        style: TextStyle(
                                                            fontFamily: "four",
                                                            fontSize: 15)),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    font_style = "five";
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 75,
                                                    color: Colors.grey,
                                                    child: Text("five",
                                                        style: TextStyle(
                                                            fontFamily: "five",
                                                            fontSize: 15)),
                                                  )),
                                            ),
                                            // InkWell(onTap: () {font_style="one";Navigator.pop(context);setState(() {});},child: Container(height: 25,width: 75,color: Colors.grey,child: Text("",style: TextStyle(fontFamily: "one")),)),
                                          ],
                                        )),
                                  ),
                                  Container(alignment: Alignment.topRight,
                                    height: 50,
                                    child: InkWell(onTap: () {
                                      Navigator.pop(context);
                                    },child: Image.asset("myasset/image/close.png")),
                                  )
                                   ],

                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Font",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 82,
                      child: Text("Emoji",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: hight,
                              child: Row(
                                children: [
                                  StatefulBuilder(
                                    builder: (context, setState1) {
                                      return Slider(
                                        min: 0,
                                        max: 100,
                                        value: b,
                                        onChanged: (value) {
                                          b = value;
                                          setState(() {});
                                          setState1(() {});
                                        },
                                      );
                                    },
                                  ),
                                  Container(alignment: Alignment.topRight,
                                    // height: 50,
                                    child: InkWell(onTap: () {
                                      Navigator.pop(context);
                                    },child: Image.asset("myasset/image/close.png")),
                                  )],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Text Size",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
