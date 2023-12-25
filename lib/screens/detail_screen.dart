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
  late Future<WebtoonDetailModel> detail;
  late Future<List<WebtoonEpisodeModel>> episodeList;

  @override
  void initState() {
    super.initState();
    detail = ApiService.getDetailById(widget.id);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
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
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: detail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age}",
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    );
                  }
                  return const Text("Loading...");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: episodeList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (var episode in snapshot.data!)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      episode.title,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                    return Container();
                  }),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
