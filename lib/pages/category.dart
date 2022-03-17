//Songs by Bhumika Vesvikar

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_space/components/custom_list_title.dart';
import 'package:my_space/pages/home_page.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  List musicList = [
    {
      'title': "Happy",
      'singer': "Pharell Williams",
      'url':
          "https://pwdown.com/9417/Happy (from Despicable Me 2) G I R L - 320Kbps.mp3",
      'coverUrl': "https://i.ytimg.com/vi/Tn5FbRYAso8/maxresdefault.jpg"
    },
    {
      'title': "Fight Song ",
      'singer': "Rachel Platten",
      'url':
          "https://www.naijafinix.com.ng/wp-content/uploads/2021/01/Rachel-Platten-Fight-Song-via-Naijafinix.com_.mp3",
      'coverUrl': "https://i.ytimg.com/vi/pvI9PuGorwI/maxresdefault.jpg"
    },
    {
      'title': "UGH!",
      'singer': "BTS",
      'url': "https://cdn.trendybeatz.com/audio/BTS-UGH!-(TrendyBeatz.com).mp3",
      'coverUrl':
          "https://mir-s3-cdn-cf.behance.net/projects/404/e1b257106253665.5f8c0600505ee.jpg"
    },
    {
      'title': "Crush",
      'singer': "Maeve",
      'url':
          "https://www.filesmp3.org/data/0/7869/ff92b6ac57f8457a22d0420ae623ebcd.mp3",
      'coverUrl': "https://i.ytimg.com/vi/c-hXyaJ-uJ4/maxresdefault.jpg"
    },
    {
      'title': "Levitating",
      'singer': "Dua Lipa ft. DaBaby",
      'url':
          "https://cdn.trendybeatz.com/audio/Dua-Lipa-Ft-DaBaby-Levitating-Remix-(TrendyBeatz.com).mp3",
      'coverUrl':
          "https://img.discogs.com/gu0bmOOmaOXN4Xk7rIwILU2lS1M=/fit-in/600x587/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-15453266-1615581384-8872.jpeg.jpg"
    },
    {
      'title': "Laugh Now Cry Later",
      'singer': "Drake ft. Lil Durk",
      'url':
          "https://www.thinknews.com.ng/wp-content/uploads/2020/08/Drake_Ft._Lil_Durk_Laugh_Now_Cry_Later.mp3",
      'coverUrl':
          "https://cheesecake.articleassets.meaww.com/469415/uploads/c6c09d70-dde6-11ea-b0d2-c155f05a7a6f_800_420.jpeg"
    },
    {
      'title': "Demons",
      'singer': "Imagine Dragons",
      'url':
          "https://bizziroute.com/mp3-songs/downloads/imagine-dragons/demons.mp3",
      'coverUrl':
          "https://upload.wikimedia.org/wikipedia/en/2/2b/Imagine_Dragons_-_%22Demons%22_%28Official_Single_Cover%29.jpg"
    },
  ];
  IconData btnIcon = Icons.pause;

  String currentTitle = "";
  String currentCover = "";
  String currentSinger = "";

  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong = "";

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black, width: 1.5),
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        audioPlayer.pause();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                Text(
                  "Wellness",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "7 Songs ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "These essential wellness songs helps to calm you mind...",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Listen Now",
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(24)),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: musicList.length,
                  itemBuilder: (context, index) => customListTile(
                      onTap: () {
                        playMusic(musicList[index]['url']);
                        setState(() {
                          currentTitle = musicList[index]['title'];
                          currentSinger = musicList[index]['singer'];
                          currentCover = musicList[index]['coverUrl'];
                        });
                      },
                      title: musicList[index]['title'],
                      singer: musicList[index]['singer'],
                      cover: musicList[index]['coverUrl']))),
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Column(
              children: [
                Slider.adaptive(value: 0.0, onChanged: (value) {}),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8, left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                                image: NetworkImage(currentCover),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTitle,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              currentSinger,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          iconSize: 42,
                          onPressed: () {
                            if (isPlaying) {
                              audioPlayer.pause();
                              setState(() {
                                btnIcon = Icons.play_arrow;
                                isPlaying = false;
                              });
                            } else {
                              audioPlayer.resume();
                              setState(() {
                                btnIcon = Icons.pause;
                                isPlaying = true;
                              });
                            }
                          },
                          icon: Icon(btnIcon))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
