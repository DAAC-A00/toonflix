import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/thumb_image_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, id;
  final Image thumbImg;

  const DetailScreen(
      {super.key,
      required this.title,
      required this.thumbImg,
      required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodeList;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getDetailById(widget.id);
    episodeList = ApiService.getEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        centerTitle: true, // detail 화면에서 appBar의 title을 중앙 정렬
        elevation: 2,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: ThumbImageWidget(thumbImg: widget.thumbImg),
              )
            ],
          ),
        ],
      ),
    );
  }
}
