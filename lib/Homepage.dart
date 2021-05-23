import 'package:flutter/material.dart';
import 'dart:math';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
// import images

  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  int luckynumber;
  int count = 10;

//get array
  List<String> itemarray;

  //counter
  counter() {
    count--;
  }

// init array
  @override
  void initState() {
    super.initState();
    itemarray = List<String>.generate(25, (index) => 'empty');
    generaterandomnumber();
  }

  generaterandomnumber() {
    int random = Random().nextInt(25);
    luckynumber = random;
  }

//play game method
  playgame(int index) {
    if ((luckynumber == index) && (count >= 1)) {
      setState(() {
        itemarray[index] = "lucky";

        counter();
      });
    } else if (count >= 1) {
      setState(() {
        itemarray[index] = "unlucky";
        counter();
      });
    } else {
      delay();
      resetgame();
    }
  }

// define getimage method
  AssetImage getimage(int index) {
    String currentstate = itemarray[index];
    switch (currentstate) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

//showall method
  showall() {
    setState(() {
      itemarray = List<String>.filled(25, 'unlucky');
      itemarray[luckynumber] = "lucky";
    });
  }

//reset method
  resetgame() {
    setState(() {
      itemarray = List<String>.filled(25, 'empty');
      count = 10;
    });
    generaterandomnumber();
  }

  //delay function
  delay() {
    Future.delayed(const Duration(milliseconds: 3500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SCRATCH AND WIN"),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: this.itemarray.length,
            itemBuilder: (context, index) => SizedBox(
              width: 50.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  this.playgame(index);
                },
                child: Image(image: this.getimage(index)),
              ),
            ),
          )),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              child: Text(
                "CHANCES LEFT",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20.0),
              child: Text(
                "$count",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.all(20.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              onPressed: () {
                this.showall();
              },
              color: Colors.pink,
              child: Text(
                "SHOW ALL!!!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              onPressed: () {
                this.resetgame();
              },
              color: Colors.pink,
              child: Text(
                "RESET",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
