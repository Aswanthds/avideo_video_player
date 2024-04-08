import 'package:in_app_review/in_app_review.dart';

class MySharedPreferences {
  static final InAppReview inAppReview = InAppReview.instance;

  static void inAppReviewApp()async{
 if (await inAppReview.isAvailable()) {
   inAppReview.openStoreListing(appStoreId: 'com.avideo.avideo_video_player',microsoftStoreId: '' );
 }
  }
}
