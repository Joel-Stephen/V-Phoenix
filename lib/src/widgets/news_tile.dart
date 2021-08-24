import 'package:app_template/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatefulWidget {
  final String description;
  final String title;
  final String image;
  final Function onPress;
  NewsTile({this.description, this.title, this.image, this.onPress});
  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.image == null
                    ? "https://i1.wp.com/fremontgurdwara.org/wp-content/uploads/2020/06/no-image-icon-2.png"
                    : widget.image,
                imageBuilder: (context, imageProvider) => Container(
                  width: screenWidth(context, dividedBy: 3.5),
                  height: screenWidth(context, dividedBy: 3.5),
                  decoration: BoxDecoration(
                    // color: Constants.kitGradients[2],
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 0.5),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: screenWidth(context, dividedBy: 3.5),
                  height: screenWidth(context, dividedBy: 3.5),
                  child: Center(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Colors.grey.withOpacity(0.3)),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
                //fit: BoxFit.cover,
              ),
            ),
            Container(
              height: screenWidth(context, dividedBy: 3.5),
              child: Column(
                children: [
                  Container(
                    width: screenWidth(context, dividedBy: 1.5),
                    padding: EdgeInsets.only(left: 5, right: 1),
                    child: widget.title == null
                        ? Container()
                        : Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: screenWidth(context, dividedBy: 25),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  SizedBox(
                    height: screenWidth(context, dividedBy: 80),
                  ),
                  Container(
                    width: screenWidth(context, dividedBy: 1.5),
                    padding: EdgeInsets.only(left: 5, right: 1),
                    child: widget.description == null
                        ? Container()
                        : Text(
                            widget.description,
                            style: TextStyle(
                                fontSize: screenWidth(context, dividedBy: 40),
                                fontWeight: FontWeight.w400),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
