import 'package:flutter/material.dart';
import 'package:segments/items_slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            slideList[index].gambar!,
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.height * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
            child: Text(
              slideList[index].title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10),
            child: Text(
              slideList[index].description!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
