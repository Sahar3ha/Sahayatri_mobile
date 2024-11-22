import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/features/auth/presentation/view/login_view.dart';
import 'package:sahayatri/features/auth/presentation/view/signup_view.dart';

void main() {
  testWidgets('LoginView widget test', (tester) async {
    // Pump the LoginView widget
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginView(),
        ),
      ),
    );

    // Wait for the widget to render
    await tester.pumpAndSettle();

    // Test if 'Welcome Back' text is displayed
    expect(find.text('Welcome Back'), findsOneWidget);

    // Test if 'Email' text field is displayed
    expect(find.byKey(const ValueKey('email')), findsOneWidget);

    // // Test if 'Password' text field is displayed
    expect(find.byType(TextFormField), findsNWidgets(2));

    // // Test if 'Login' button is displayed
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // // Test if 'Register Now' text is displayed
    expect(find.text('Register Now'), findsOneWidget);

    // // Tap on the 'Register Now' text
    await tester.tap(find.text('Register Now'));

    // // Wait for the navigation to complete
    await tester.pumpAndSettle();

    // // Verify that the navigation occurred
    expect(find.text('Register Now'), findsOneWidget);
  });
  group("login test widget", () {
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginView), findsOneWidget); // Use LoginPage as a type
    });
    testWidgets('Login testing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'a@gmail.com');
      await tester.enterText(find.byType(TextField).last, '123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
  group("register test widget", () {
    testWidgets('renders RegisterView from login page on click',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const LoginView(),
            routes: AppRoute.getApplication(), // Ensure routes are set
          ),
        ),
      );
      // Wait for the widgets to settle
      await tester.pumpAndSettle();
      // Tap the button with the specified key ("SignUpButton")
      await tester.tap(find.text("Register Now"));
      // Wait for the widgets to settle after the button tap
      await tester.pumpAndSettle();
    });

    testWidgets('renders RegisterView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignUpView(),
          ),
        ),
      );
      // Expect that a Scaffold is rendered
      expect(find.byType(Scaffold), findsOneWidget);
      // Expect that the RegisterPage is rendered
      expect(find.byType(SignUpView), findsOneWidget);
    });
  });
}
