import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/const/app_colors.dart';
import 'package:music_player/view/home_controller.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.black12,
              appBar: AppBar(
                title: controller.appBarTitle,
                actions: [
                  GestureDetector(
                      onTap: () {
                        if (controller.actionIcon.icon == Icons.search) {
                          controller.actionIcon =
                              const Icon(Icons.close, color: Colors.white);
                          controller.appBarTitle = TextField(
                            controller: controller.searchController,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.white),
                                hintText: "Search...",
                                hintStyle: TextStyle(color: Colors.white)),
                            onSubmitted: (value) {
                              controller.fetchMusic(
                                  value.replaceAll(" ", "+").trim());
                            },
                          );
                        } else {
                          controller.actionIcon =
                              const Icon(Icons.search, color: Colors.white);
                          controller.appBarTitle = const Text("Music Player");
                        }
                        controller.update();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: controller.actionIcon,
                      ))
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      // child: controller.musicList != null &&
                      child: !controller.isLoading.value &&
                              controller.errorMessage.isEmpty == true
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemExtent: 67,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.musicList?.length ?? 0,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Assign played to music control of the bottom
                                    controller.currentlyPlayingMusic =
                                        controller.musicList?[index];
                                    // Assign current selected music index from the list
                                    controller.currentlyPlayingIndex = index;
                                    // initialize to play music
                                    controller.playAudioFromUrl(controller
                                        .musicList?[index].previewUrl);
                                    // update / repaint the widget and assign instantiated variable
                                    controller.update();
                                  },
                                  child: ListTile(
                                    leading: Image.network(
                                        controller.musicList?[index]
                                                .artworkUrl60 ??
                                            "-",
                                        height: 48,
                                        width: 48),
                                    title: Text(
                                        controller.musicList?[index].trackName
                                                .toString() ??
                                            "-",
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    subtitle: Text(
                                        "${controller.musicList?[index].artistName.toString()}\n${controller.musicList?[index].collectionName}",
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                    trailing: Visibility(
                                      visible:
                                          controller.currentlyPlayingIndex ==
                                              index,
                                      child: Lottie.asset(
                                          "assets/lottie/lottie_music_waves.json"),
                                    ),
                                  ),
                                );
                              })
                          : const Center(
                              child: CircularProgressIndicator.adaptive()),
                    ),
                  ),
                  Visibility(
                      visible: controller.currentlyPlayingMusic != null,
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(controller
                                          .currentlyPlayingMusic
                                          ?.artworkUrl60 ??
                                      "-"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width - 100,
                                        child: Text(
                                            controller.currentlyPlayingMusic
                                                    ?.trackName
                                                    .toString() ??
                                                "-",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                      const Divider(color: Colors.transparent),
                                      SizedBox(
                                        width: Get.width - 100,
                                        child: Text(
                                            controller.currentlyPlayingMusic
                                                    ?.artistName
                                                    .toString() ??
                                                "-",
                                            maxLines: 2,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 12)),
                                      ),
                                      SizedBox(
                                        width: Get.width - 100,
                                        child: Text(
                                            controller.currentlyPlayingMusic
                                                ?.collectionName
                                                .toString() ??
                                                "-",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.previousMusic();
                                      },
                                      icon: const Icon(Icons.skip_previous,
                                          color: primaryColor, size: 32)),
                                  IconButton(
                                      onPressed: () {
                                        if (controller
                                                .currentlyPlayingState.value ==
                                            true) {
                                          controller.pauseMusic();
                                        } else {
                                          controller.resumeMusic();
                                        }
                                      },
                                      icon:
                                          controller.currentlyPlayingState.value
                                              ? const Icon(Icons.pause,
                                                  color: primaryColor, size: 32)
                                              : const Icon(Icons.play_arrow,
                                                  color: primaryColor,
                                                  size: 32)),
                                  IconButton(
                                      onPressed: () {
                                        controller.nextMusic();
                                      },
                                      icon: const Icon(Icons.skip_next,
                                          color: primaryColor, size: 32)),
                                ]),
                            Slider(
                                activeColor: primaryColor,
                                value: controller.currentPlayingDuration.value
                                    .toDouble(),
                                max: controller.maxDuration.value.toDouble(),
                                onChanged: (newValue) {
                                  controller.setSeekbar(newValue.toInt());
                                })
                          ],
                        ),
                      ))
                ],
              ),
            ));
  }
}
