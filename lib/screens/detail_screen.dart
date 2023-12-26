import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/thumb_image_widget.dart';

import '../widgets/episode_widget.dart';

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
  // favorite
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      // 데이터가 존재는 한다면, id를 포함하는지 확인
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      // 데이터가 아예 없으면 빈 list 만들어주기
      await prefs.setStringList("likedToons", []);
    }
  }

  @override
  void initState() {
    super.initState();
    detail = ApiService.getDetailById(widget.id);
    episodeList = ApiService.getEpisodesById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList("likedToons", likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: onHeartTap,
              icon: Icon(isLiked
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded)),
        ],
        centerTitle: true, // detail 화면에서 appBar의 title을 중앙 정렬
        elevation: 2,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
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
                            EpisodeWidget(
                                episode: episode, widgetId: widget.id),
                        ],
                      );
                    }
                    return const Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          CircularProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.blue,
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
