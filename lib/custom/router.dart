import 'package:dikla_spirit/model/auth/forgot_password_model.dart';
import 'package:dikla_spirit/screens/auth/app_settings.dart';
import 'package:dikla_spirit/screens/auth/forgot_password_screen.dart';
import 'package:dikla_spirit/screens/auth/login_options_screen.dart';
import 'package:dikla_spirit/screens/auth/login_screen.dart';
import 'package:dikla_spirit/screens/auth/reset_pass_screen.dart';
import 'package:dikla_spirit/screens/auth/signup_screen.dart';
import 'package:dikla_spirit/screens/check_out/address_list_screen.dart';
import 'package:dikla_spirit/screens/check_out/address_widget_wrapper.dart';
import 'package:dikla_spirit/screens/check_out/step_ui.dart';
import 'package:dikla_spirit/screens/dashboard/dashboard_screen.dart';
import 'package:dikla_spirit/screens/help_center/help_center_screen.dart';
import 'package:dikla_spirit/screens/help_center/submit_request_screen.dart';
import 'package:dikla_spirit/screens/home.dart';
import 'package:dikla_spirit/screens/my_cart_screen.dart';
import 'package:dikla_spirit/screens/onboarding/onboarding_screen.dart';
import 'package:dikla_spirit/screens/orders/my_orders_screen.dart';
import 'package:dikla_spirit/screens/orders/order_details_screen.dart';
import 'package:dikla_spirit/screens/product/product_cat_list_screen.dart';
import 'package:dikla_spirit/screens/product/product_details_screen.dart';
import 'package:dikla_spirit/screens/onboarding/splash_screen.dart';
import 'package:dikla_spirit/screens/profile/profile_screen.dart';
import 'package:dikla_spirit/screens/profile/zodiac_sign_screen.dart';
import 'package:dikla_spirit/screens/reviews/our_reviews_screen.dart';
import 'package:dikla_spirit/screens/wishlist/wish_list_screen.dart';
import 'package:dikla_spirit/widgets/product_details_widget.dart';
import 'package:dikla_spirit/widgets/search_widget/search_widget.dart';
import 'package:go_router/go_router.dart';

class CustomRouter {
  static final GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        routes: [
          GoRoute(
            name: "dashboard",
            path: '/dashboard',
            builder: (context, state) {
              return DashboardScreen();
            },
          ),
          GoRoute(
            name: "cart",
            path: '/cart',
            builder: (context, state) {
              return MyCartScreen();
            },
          ),
          GoRoute(
            name: "product",
            path: '/product',
            builder: (context, state) {
              final id = state.extra as Map<String, dynamic>;
              return ProductCategoryListScreen(id["id"], id["name"]);
            },
          ),
          GoRoute(
            name: "product_Detail",
            path: '/product_detail',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return ProductDetailsScreen(data["id"], data["name"]);
            },
          ),
          GoRoute(
            name: "wishlist",
            path: '/wishlist',
            builder: (context, state) {
              return WishListScreen();
            },
          ),
          GoRoute(
            name: "my_orders",
            path: '/my_orders',
            builder: (context, state) {
              return MyOrdersScreen();
            },
          ),
          GoRoute(
            name: "order_details",
            path: '/order_details',
            builder: (context, state) {
              final data = state.extra as String;
              return OrderDetailsScreen(data);
            },
          ),
        ],
        builder: (context, state, child) {
          return HomeWidget(
            child: child,
          );
        },
      ),

      /// Without Bottom Navigation Bar
      GoRoute(
        name: "splash",
        path: '/',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        name: "onboarding",
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        name: "login",
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: "login_options",
        path: '/login_options',
        builder: (context, state) => LoginOptionsScreen(),
      ),
      GoRoute(
        name: "signup",
        path: '/signup',
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        name: "forgotPassword",
        path: '/forgotPassword',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        name: "resetPassword",
        path: '/resetPassword',
        builder: (context, state) {
          final data = state.extra as ForgotPasswordModelData;
          return ResetPassScreen(data: data);
        },
      ),
      GoRoute(
        name: "appSettings",
        path: '/appSettings',
        builder: (context, state) => AppSettingsScreen(),
      ),
      GoRoute(
        name: "steps",
        path: '/steps',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return StepProgressScreen(data["template"]);
        },
      ),
      GoRoute(
        name: "address_list",
        path: '/address_list',
        builder: (context, state) => AddressListScreen(),
      ),
      GoRoute(
        name: "help_center",
        path: '/help_center',
        builder: (context, state) => HelpCenterScreen(),
      ),
      GoRoute(
        name: "address_widget",
        path: '/address_widget',
        builder: (context, state) => AddressWidgetWrapper(),
      ),
      GoRoute(
        name: "image_viewer",
        path: '/image_viewer',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return ProductDetailImageViewer(
            imageUrls: data["urls"],
            initialIndex: data["index"],
          );
        },
      ),
      GoRoute(
          name: "submit_request",
          path: '/submit_request',
          builder: (context, state) => SubmitRequestScreen()),
      GoRoute(
          name: "search_widget",
          path: '/search_widget',
          builder: (context, state) => SearchScreen()),
      GoRoute(
        name: "our_reviews",
        path: '/our_reviews',
        builder: (context, state) => OurReviewsScreen(true),
      ),
      GoRoute(
        name: "set_profile_details",
        path: '/set_profile_details',
        builder: (context, state) => MyProfileScreen(),
      ),
      GoRoute(
        name: "zodiac_screen",
        path: '/zodiac_screen',
        builder: (context, state) => ZodiacSignScreen(),
      ),
    ],
  );
}
