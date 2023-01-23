import 'package:uppercut_fantube/utilities/index.dart';

enum BottomNavigationConstants {
  home(
    label: '홈',
    icon: Icon(Icons.home),
  ),
  business(
    label: '탐색',
    icon: Icon(Icons.video_collection),
  ),
  school(
    label: '마에페이지',
    icon: Icon(Icons.person),
  );

  final String label;
  final Icon icon;

  const BottomNavigationConstants({
    required this.label,
    required this.icon,
  });
}
