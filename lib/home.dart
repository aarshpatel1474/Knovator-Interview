import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ItemShape> listOfItems = [];

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: listOfItems,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            addItem(1);
          } else if (index == 1) {
            addItem(2);
          } else {
            addItem(3);
          }
        },
        items: [
          bottomWidget("assets/images/circle.png"),
          bottomWidget("assets/images/rectangle.png"),
          bottomWidget("assets/images/triangle.png"),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomWidget(path) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        path,
        height: 20,
        width: 20,
        fit: BoxFit.cover,
      ),
      label: "",
    );
  }

  void updateShape(index) {
    listOfItems[index] = ItemShape(
      onTap: updateShape,
      index: index,
      type: listOfItems[index].type == 3
          ? 2
          : listOfItems[index].type == 2
              ? 1
              : 0,
      xPos: listOfItems[index].xPos,
      yPos: listOfItems[index].yPos,
    );

    setState(() {});
  }

  void addItem(type) {
    listOfItems.add(ItemShape(
      onTap: updateShape,
      index: listOfItems.length,
      type: type,
      xPos: double.parse(
          random.nextInt(MediaQuery.of(context).size.width.toInt()).toString()),
      yPos: double.parse(random
          .nextInt(MediaQuery.of(context).size.height.toInt() - 100)
          .toString()),
    ));

    setState(() {});
  }
}

class ItemShape extends StatelessWidget {
  final Function onTap;
  final int index;
  final int type;
  final double xPos;
  final double yPos;

  const ItemShape(
      {Key? key,
      required this.onTap,
      required this.index,
      required this.type,
      required this.xPos,
      required this.yPos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: yPos,
        left: xPos,
        child: InkWell(
          onTap: ()=>onTap(index),
          child: Stack(
            children: [
              type == 1
                  ? Image.asset("assets/images/circle.png",
                      height: 50, width: 50, fit: BoxFit.cover)
                  : type == 2
                      ? Image.asset("assets/images/rectangle.png",
                          height: 50, width: 50, fit: BoxFit.cover)
                      : type == 3
                          ? Image.asset("assets/images/triangle.png",
                              height: 50, width: 50, fit: BoxFit.cover)
                          : const SizedBox.shrink(),
            ],
          ),
        ));
  }
}
