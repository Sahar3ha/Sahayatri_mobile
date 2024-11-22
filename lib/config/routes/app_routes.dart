
import 'package:sahayatri/features/auth/presentation/view/login_view.dart';
import 'package:sahayatri/features/favourites/presentation/view/favourites_view.dart';
import 'package:sahayatri/features/favourites/presentation/view/profile_view.dart';
import 'package:sahayatri/features/auth/presentation/view/signup_view.dart';
import 'package:sahayatri/features/auth/presentation/view/splashscreen_view.dart';
import 'package:sahayatri/features/feedback/presentation/view/feedbacks.dart';
import 'package:sahayatri/features/home/presentation/view/home_view.dart';
import 'package:sahayatri/features/notifications/presentation/view/notification_view.dart';
import 'package:sahayatri/features/sensors/proximity.dart';
import 'package:sahayatri/features/vehicles/presentation/view/vehicle_view.dart';


class AppRoute {
  AppRoute._();
  static const String splashscreenRoute = '/SplashScreen';
  static const String loginRoute = '/LoginScreen';
  static const String signUpRoute = '/SignUpScreen';
  static const String profileRoute = '/ProfileScreen';
  static const String vehicleRoute = '/VehicleScreen';
  static const String feedbackRoute = '/feedbackScreen';
  static const String mapRoute = '/Map';
  static const String dashboard = '/Map';



  static const String favouritesRoute = '/FavourtiesScreen';
  static const String notificationRoute = '/NotificationScreen';
  static const String accelometer = '/Accelometer';
  static const String next = '/Next';

  static getApplication() {
    return {
      splashscreenRoute: (context) => const SplashScreenView(),
      loginRoute: (context) => const LoginView(),
      signUpRoute: (context) => const SignUpView(),
      profileRoute: (context) => const ProfileView(),
      favouritesRoute: (context) => const FavouritesView(),
      vehicleRoute: (context) => const VehicleView(),
      feedbackRoute: (context) => const FeedbackView(),
      notificationRoute: (context) => const NotificationsView(),
      accelometer: (context) => const ProximityScreen(),
      next: (context) => const Next(),
      dashboard: (context) => const HomeView(),
      
    
    };
  }
}
