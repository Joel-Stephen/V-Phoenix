import 'package:app_template/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTileLoader extends StatefulWidget {
  @override
  _NewsTileLoaderState createState() => _NewsTileLoaderState();
}

class _NewsTileLoaderState extends State<NewsTileLoader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: screenWidth(context, dividedBy: 3.5),
            height: screenWidth(context, dividedBy: 3.5),
            color: Colors.blueGrey.withOpacity(0.2),
          ),
          SizedBox(width: screenWidth(context,dividedBy: 100),),
          Container(
            height: screenWidth(context,dividedBy: 3.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth(context,dividedBy: 1.6),
                  height: screenHeight(context,dividedBy: 50),
                  color: Colors.blueGrey.withOpacity(0.2),
                ),
                SizedBox(height: screenWidth(context,dividedBy: 150),),
                Container(
                  width: screenWidth(context,dividedBy: 2),
                  height: screenHeight(context,dividedBy: 50),
                  color: Colors.blueGrey.withOpacity(0.2),
                ),
                SizedBox(height: screenWidth(context,dividedBy: 60),),
                Container(
                  width: screenWidth(context,dividedBy: 1.6),
                  height: screenHeight(context,dividedBy: 70),
                  color: Colors.blueGrey.withOpacity(0.2),
                ),
                SizedBox(height: screenWidth(context,dividedBy: 150),),
                Container(
                  width: screenWidth(context,dividedBy: 1.6),
                  height: screenHeight(context,dividedBy: 70),
                  color: Colors.blueGrey.withOpacity(0.2),
                ),
                SizedBox(height: screenWidth(context,dividedBy: 150),),
                Container(
                  width: screenWidth(context,dividedBy: 2),
                  height: screenHeight(context,dividedBy: 70),
                  color: Colors.blueGrey.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
