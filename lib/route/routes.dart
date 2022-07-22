import 'package:get/get.dart';
import 'package:music_player/view/home_screen.dart';

List<GetPage> pages = [
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
];