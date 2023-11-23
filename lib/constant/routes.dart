// import 'package:apnashyam/screens/bookings/booking_details.dart';
// import 'package:apnashyam/screens/bookings/boooked_screen.dart';
// import 'package:apnashyam/screens/bookings/review_booking.dart';
// import 'package:apnashyam/screens/deals/popular_destination.dart';
// import 'package:apnashyam/screens/deals/reviews.dart';
// import 'package:apnashyam/screens/deals/write_review.dart';
// import 'package:apnashyam/screens/explore/best_deal.dart';
// import 'package:apnashyam/screens/explore/country_details.dart';
// import 'package:apnashyam/screens/explore/explore_screen.dart';
// import 'package:apnashyam/screens/hotels/hotels_details.dart';
// import 'package:apnashyam/screens/logins/email_verification_signup.dart';
//
// // import 'package:apnashyam/screens/logins/reset_password.dart';
// import 'package:apnashyam/screens/logins/forgot_success.dart';
// import 'package:apnashyam/screens/logins/hotelOrRickshawBooking_screen.dart';
//
// // import 'package:apnashyam/screens/logins/signup_success.dart';
// import 'package:apnashyam/screens/payment/card_detail.dart';
// import 'package:apnashyam/screens/payment/payment_method.dart';
// import 'package:apnashyam/screens/profile/assistant/answer.dart';
// import 'package:apnashyam/screens/profile/assistant/help_support.dart';
// import 'package:apnashyam/screens/profile/assistant/message_screen.dart';
// import 'package:apnashyam/screens/profile/coupons.dart';
// import 'package:apnashyam/screens/profile/profile_edit.dart';
// import 'package:apnashyam/screens/profile/profile_screens.dart';
// import 'package:apnashyam/screens/profile/settings/notification_screen.dart';
// import 'package:apnashyam/screens/profile/settings/profile_settings.dart';
// import 'package:apnashyam/screens/rooms/room_detail.dart';
// import 'package:apnashyam/screens/rooms/rooms_list.dart';
// import 'package:apnashyam/screens/search/filter_screen.dart';
// import 'package:apnashyam/screens/search/search_screen.dart';
//
// // import 'package:apnashyam/screens/startups/first_screen.dart';
// import 'package:apnashyam/utils/library.dart';
//
// import '../screens/bookings/bookings_screen.dart';
// import '../screens/logins/otp_screen.dart';
// import '../screens/profile/settings/privacyPolicyScreen.dart';
// import '../screens/profile/settings/termsOfServiceScreen.dart';

// Static Name For PageNavigation
import 'package:apnashyamowner/screens/bookings/cancelled_bookings.dart';
import 'package:apnashyamowner/screens/bookings/finished_bookings.dart';
import 'package:apnashyamowner/screens/bookings/upcoming_bookings.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/bookings/bookings_screen.dart';
import '../screens/other/answer.dart';
import '../screens/other/help_support.dart';
import '../screens/other/message_screen.dart';
import '../screens/userAuth/login_screen.dart';
import '../settings/profile_screens.dart';
import '../settings/notification_screen.dart';
import '../settings/privacyPolicyScreen.dart';
import '../settings/profile_settings.dart';
import '../settings/termsOfServiceScreen.dart';

class MyRoutes {
  static const firstScreen = '/FirstScreen';
  static const logIn = '/Login';
  static const signUp = '/SignUp';
  static const emailVerificationSignup = '/VerificationSignup';
  static const emailVerificationPaasword = '/VerificationPassword';
  static const hotelList = '/HotelList';
  static const exploreScreen = '/ExploreScreen';
  static const resetPassword = '/ResetPassword';
  static const forgotPassScreen = '/ForgotPassScreen';
  static const customNavBar = '/CustomNavBar';
  static const searchScreen = '/SearchScreen';
  static const signupSuccess = '/SignupSuccess';
  static const forgotSuccess = '/ForgotSuccess';
  static const countryDetails = '/CountryDetails';
  static const hotelDetails = '/HotelDetails';
  static const bestDealsScreen = '/BestDealsScreen';
  static const bookingDetails = '/BookingDetails';
  static const bookedScreen = '/BookedScreen';
  static const paymentScreen = '/PaymentScreen';
  static const popularDestination = '/PopularDestination';
  static const reviewBooking = '/ReviewBooking';
  static const writeReview = '/WriteReview';
  static const bookingsScreen = '/BookingsScreen';
  static const reviews = '/Reviews';
  static const roomList = '/RoomList';
  static const cardDetails = '/CardDetails';
  static const roomDetails = '/RoomDetails';
  static const filterScreen = '/FilterScreen';
  static const helpSupportMessageScreen = '/HelpSupportMessageScreen';
  static const editProfile = '/EditProfile';
  static const answerScreen = '/AnswerScreen';
  static const profileSettings = '/ProfileSettings';
  static const profileScreen = '/ProfileScreen';
  static const upcomingBookings = '/UpcomingBookings';
  static const finishedBooking = '/FinishedBooking';
  static const cancelledBooking = '/CancelledBooking';
  static const helpSupportScreen = '/HelpSupportScreen';
  static const couponsScreen = '/CouponsScreen';
  static const notificationScreen = '/NotificationScreen';
  static const termsOfServiceScreen = '/TermsOfServiceScreen';
  static const privacyPOlicyScreen = '/PrivacyPOlicyScreen';
  static const otpScreen = '/OtpScreen';
}

// Ongenerate Method For Navigation
Route<dynamic>? generateRoute(RouteSettings settings, BuildContext context) {
  switch (settings.name) {
    // case MyRoutes.signupSuccess:
    //   return pageNavigator(const SignUpSuccessfull());

    // case MyRoutes.emailVerificationSignup:
    //   List<dynamic> args = settings.arguments as List<dynamic>;
    //   return pageNavigator(EmailVerificationSignUp(
    //     email: args[0],
    //   ));

    // case MyRoutes.resetPassword:
    //   return pageNavigator(const ResetPassword());

    // case MyRoutes.firstScreen:
    //   return pageNavigator(const FirstScreen());

    case MyRoutes.notificationScreen:
      return pageNavigator(const NotificationScreen());

    case MyRoutes.termsOfServiceScreen:
      return pageNavigator(const TermsOfServiceScreen());

    case MyRoutes.privacyPOlicyScreen:
      return pageNavigator(const PrivacyPOlicyScreen());

    // case MyRoutes.forgotSuccess:
    //   return pageNavigator(const ResetPasswordSuccessfull());
    //
    // case MyRoutes.couponsScreen:
    //   return pageNavigator(CouponsScreen());
    //
    // case MyRoutes.editProfile:
    //   return pageNavigator(CreateProfile());

    case MyRoutes.helpSupportScreen:
      return pageNavigator(const HelpSupportScreen());

    case MyRoutes.profileSettings:
      return pageNavigator(const ProfileSettings());

    case MyRoutes.profileScreen:
      return pageNavigator(const ProfileScreen());

    case MyRoutes.upcomingBookings:
      return pageNavigator(UpcomingBookings());

    case MyRoutes.finishedBooking:
      return pageNavigator(FinishedBooking());

    case MyRoutes.cancelledBooking:
      return pageNavigator(CancelledBooking());

    case MyRoutes.answerScreen:
      List<dynamic> args = settings.arguments as List<dynamic>;
      return pageNavigator(AnswerScreen(
        question: args[0],
        answer: args[1],
      ));

    case MyRoutes.helpSupportMessageScreen:
      return pageNavigator(const HelpSupportMessageScreen());

    // case MyRoutes.filterScreen:
    //   return pageNavigator(const FilterScreen());
    //
    // case MyRoutes.roomDetails:
    //   return pageNavigator(const RoomDetails());
    //
    // case MyRoutes.cardDetails:
    //   return pageNavigator(const CardDetail());
    //
    // case MyRoutes.roomList:
    //   return pageNavigator(const RoomsList());
    //
    // case MyRoutes.reviews:
    //   return pageNavigator(Reviews());
    //
    // case MyRoutes.writeReview:
    //   return pageNavigator(const WriteReview());
    //
    case MyRoutes.bookingsScreen:
      return pageNavigator(const BookingsScreen());
    //
    // case MyRoutes.reviewBooking:
    //   List<dynamic> args = settings.arguments as List<dynamic>;
    //   return pageNavigator(ReviewBooking(hotel: args[0],roomId:args[1],checkIn: args[2],checkInDate: args[3],checkOut: args[4],checkOutDate: args[5],rooms: args[6],adults: args[7],children: args[8],people: args[9]));
    //
    // case MyRoutes.popularDestination:
    //   return pageNavigator(const PopularDestination());
    //
    // case MyRoutes.paymentScreen:
    //   return pageNavigator(const PaymentMethod());
    //
    // case MyRoutes.bookedScreen:
    //   return pageNavigator(const BookedSuccessful());
    //
    // case MyRoutes.bestDealsScreen:
    //   return pageNavigator(const BestDealScreen());
    //
    // case MyRoutes.bookingDetails:
    //   List<dynamic> args = settings.arguments as List<dynamic>;
    //   return pageNavigator(BookingDetails(hotelDetailResponseModel: args[0], roomId: args[1],));
    //
    // case MyRoutes.hotelDetails:
    //   List<dynamic> args = settings.arguments as List<dynamic>;
    //   return pageNavigator(HotelDeatails(hotelId: args[0]));
    //
    // case MyRoutes.otpScreen:
    //   List<dynamic> args = settings.arguments as List<dynamic>;
    //   return pageNavigator(OtpScreen(otp: args[0],mobile: args[1],));
    //
    // case MyRoutes.hotelOrRickshawBookingScreen:
    //   return pageNavigator(const HotelOrRickshawBookingScreen());
    //
    // case MyRoutes.countryDetails:
    //   DataModel? args = settings.arguments as DataModel;
    //   return pageNavigator(CountryDetails(data: args));
    //
    // case MyRoutes.searchScreen:
    //   return pageNavigator(const SearchScreen());

    case MyRoutes.logIn:
      return pageNavigator(
        const LoginScreen(),
      );
    // PageRouteBuilder(
    //     settings:
    //         settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
    //     pageBuilder: (_, __, ___) => const LoginScreen(),
    //     transitionsBuilder: (_, a, __, b) => FadeTransition(
    //           opacity: a,
    //           child: b,
    //         ));

    // case MyRoutes.signUp:
    //   return pageNavigator(
    //     const SignUpScreen(),
    //   );

  //   case MyRoutes.emailVerificationPaasword:
  //     List<dynamic> args = settings.arguments as List<dynamic>;
  //     return pageNavigator(
  //       EmailVerificationPassword(
  //         email: args[0],
  //       ),
  //     );
  //
  //   case MyRoutes.forgotPassScreen:
  //     return pageNavigator(
  //       const ForgotPasswordScreen(),
  //     );
  //
  //   case MyRoutes.hotelList:
  //     List<dynamic> args = settings.arguments as List<dynamic>;
  //     return pageNavigator(HotelList(
  //       hotel: args[0],
  //       checkIn: args[1],
  //       checkOut: args[2],
  //       rooms: args[3],
  //       people: args[4],
  //       fromSearch: args[5],
  //     ));
  //
  //   case MyRoutes.exploreScreen:
  //     List<dynamic> args = settings.arguments as List<dynamic>;
  //     return pageNavigator(ExploreScreen(
  //       short_type: args[0],
  //       price_min: args[1],
  //       price_max: args[2],
  //       distance_min: args[3],
  //       distance_max: args[4],
  //       rating: args[5],
  //       car_parking: args[6],
  //       category_id: args[7],
  //     ));
  //   case MyRoutes.customNavBar:
  //     int? args = settings.arguments as int?;
  //     return pageNavigator(
  //       const CustomNavBar(),
  //     );
  }
  return null;
}

// Method For PageTransition
PageTransition<dynamic> pageNavigator(page) {
  return PageTransition(
    opaque: true,
    duration: const Duration(milliseconds: 700),
    isIos: true,
    child: page,
    type: PageTransitionType.fade,
  );
}
