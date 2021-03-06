import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc_pattern/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_bloc_pattern/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(video.thumb, fit: BoxFit.cover),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        video.title,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: TextStyle(fontSize: 14),
                        )),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: bloc.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return IconButton(
                      icon: Icon(snapshot.data.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border),
                      color: Colors.black,
                      iconSize: 20,
                      onPressed: () {
                        bloc.toggleFavorite(video);
                      },
                    );
                  else
                    return CircularProgressIndicator();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
