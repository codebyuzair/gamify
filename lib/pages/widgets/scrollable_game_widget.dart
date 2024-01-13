import 'package:flutter/material.dart';
import 'package:gamify/data.dart';

class ScrollableGameWidget extends StatelessWidget {
  const ScrollableGameWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.showTitle,
      required this.gameData});

  final double height;
  final double width;
  final bool showTitle;
  final List<Game> gameData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: gameData.map((game) {
            return Container(
              height: height,
              width: width * 0.30,
              padding: EdgeInsets.only(right: width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: height * 0.77,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          game.coverImage.url,
                        ),
                      ),
                    ),
                  ),
                  showTitle ? Text(
                    game.title,
                    maxLines: 2,
                    style:
                        TextStyle(color: Colors.white, fontSize: height * 0.081),
                  ) : Container(), 
                ],
              ),
            );
          }).toList()),
    );
  }
}
