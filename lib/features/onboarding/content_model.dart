import 'package:hola_academy/core/constants/image_manager.dart';

class UnbordingContent {
  String? image;
  String? title;
  String? discription;

  UnbordingContent({this.image, this.title, this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Enhance Your Swimming Skills',
      image: ImageManager.onBoardingImage1,
      discription:
          '''Track your progress, improve your techniques, \n and achieve your swimming goals effortlessly!'''),
  UnbordingContent(
      title: 'Personalized Skill Evaluations',
      image: ImageManager.onBoardingImage2,
      discription:
          ''' Get assessed by expert coaches and unlock levels tailored to help you succeed based on\n your progress!'''),
  UnbordingContent(
      title: 'Stay Connected and Organized',
      image: ImageManager.onBoardingImage3,
      discription:
          ''' Access your training schedules, receive reminders, and stay updated with all your \n swimming classes effortlessly!'''),
];
