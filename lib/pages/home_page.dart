import 'package:flutter/material.dart';
import 'package:gamify/pages/widgets/scrollable_game_widget.dart';
import '../data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic _deviceHeight;
  dynamic _deviceWidth;
  dynamic _selectedGame;

  @override
  void initState() {
    super.initState();
    _selectedGame = 0;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _featuredGamesWidget(),
          _gradientBoxWidget(),
          _topLayerWidget(),
        ],
      ),
    );
  }

  Widget _featuredGamesWidget() {
    return SizedBox(
        height: _deviceHeight * 0.5,
        width: _deviceWidth,
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              _selectedGame = index;
            });
          },
          scrollDirection: Axis.horizontal,
          children: featuredGames.map((game) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(game.coverImage.url),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _gradientBoxWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: _deviceHeight * 0.80,
        width: _deviceWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 45, 59, 1.0),
              Colors.transparent,
            ],
            stops: [0.65, 10.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Widget _topLayerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.05,
        vertical: _deviceHeight * 0.005,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _topBarWidget(),
          SizedBox(height: _deviceHeight * 0.12),
          _featuredGamesInfoWidget(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.01,
            ),
            
            child: ScrollableGameWidget(
              height: _deviceHeight * 0.21,
              width: _deviceWidth,
              showTitle: true,
              gameData: games,
            ),
          ),
          featuredGamebannerWidget(),
          SizedBox(height: _deviceHeight * 0.017),
          ScrollableGameWidget(
            height: _deviceHeight * 0.21,
            width: _deviceWidth,
            showTitle: false,
            gameData: games2,
          )
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return SizedBox(
      height: _deviceHeight * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.menu, size: 30, color: Colors.white),
          SizedBox(width: _deviceWidth * 0.3),
          const Row(children: <Widget>[
            Icon(Icons.search, size: 30, color: Colors.white),
            Icon(Icons.notifications_none, size: 30, color: Colors.white),
          ]),
        ],
      ),
    );
  }

  Widget _featuredGamesInfoWidget() {
    return SizedBox(
      height: _deviceHeight * 0.13,
      width: _deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            featuredGames[_selectedGame].title,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: _deviceHeight * 0.04,
            ),
          ),
          SizedBox(height: _deviceHeight * 0.001),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: featuredGames.map((game) {
              bool isActive = game.title == featuredGames[_selectedGame].title;
              double circleRadius = _deviceHeight * 0.011;
              return Container(
                margin: EdgeInsets.only(left: _deviceWidth * 0.015),
                height: circleRadius * 0.6,
                width: circleRadius / 2,
                decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(100)),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget featuredGamebannerWidget() {
    return Container(
      height: _deviceHeight * 0.13,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(featuredGames[3].coverImage.url),
        ),
      ),
    );
  }
}
