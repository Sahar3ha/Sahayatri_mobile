// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:sahayatri/config/routes/app_routes.dart';
// import 'package:sahayatri/features/auth/domain/use_case/user_login_use_case.dart';
// import 'package:sahayatri/features/auth/presentation/view/login_view.dart';
// import 'package:sahayatri/features/auth/presentation/view/signup_view.dart';
// import 'package:sahayatri/features/auth/presentation/viewmodel/login_view_model.dart';
// import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
// import 'package:sahayatri/features/vehicles/domain/usecase/get_all_vehicles.dart';
// import 'package:sahayatri/features/vehicles/presentation/view_model/vehicle_view_model.dart';

// import '../../../../test_data/vehicle_entity_test.dart';
// import 'login_view_test.mocks.dart';

// @GenerateNiceMocks([
//   MockSpec<LoginUseCase>(),
//   MockSpec<BuildContext>(),
//   MockSpec<GetAllVehicleUseCase>(),
// ])
// void main() {
//   int page = 0;
//   late bool isLogin;
//   late List<VehicleEntity> vehicles;
//   late LoginUseCase mockLoginUseCase;
//   late GetAllVehicleUseCase mockGetAllVehiclesUseCase;
  
//   setUpAll(() async {
//     mockLoginUseCase = MockLoginUseCase();
//     mockGetAllVehiclesUseCase = MockGetAllVehicleUseCase();
//     vehicles = await getvehicles();
//     isLogin = true;
//   });

//   testWidgets('login test with username and password and open dashboard',
//       (WidgetTester tester) async {
//     when(mockLoginUseCase.loginUser('a@gmail.com', '123'))
//         .thenAnswer((_) async => Right(isLogin));

//     when(mockGetAllVehiclesUseCase.getAllVehicles(page))
//         .thenAnswer((_) async => Right(vehicles));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           loginViewModelProvider
//               .overrideWith((ref) => LoginViewModel(mockLoginUseCase)),
//           vehicleViewModelProvider
//               .overrideWith((ref) => VehicleViewModel(mockGetAllVehiclesUseCase)),
          
//         ],
//         child: MaterialApp(
//           initialRoute: AppRoute.loginRoute,
//           routes: AppRoute.getApplication(),
//         ),
//       ),
//     );
//     await tester.pumpAndSettle();

//     // Type in first textformfield/TextField
//     await tester.enterText(find.byType(TextField).at(0), 'a@gmail.com');
//     // Type in second textformfield
//     await tester.enterText(find.byType(TextField).at(1), '123');

//     await tester.tap(
//       find.widgetWithText(ElevatedButton, 'Login'),
//     );

//     await tester.pumpAndSettle();

//     expect(find.text('Dashboard View'), findsOneWidget);
//   });
//   group("login test widget", () {
//     testWidgets('renders LoginView', (tester) async {
//       await tester.pumpWidget(
//         const ProviderScope(
//           child: MaterialApp(
//             home: LoginView(),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//       expect(find.byType(LoginView), findsOneWidget); // Use LoginPage as a type
//     });
//     testWidgets('Login testing', (tester) async {
//       await tester.pumpWidget(
//         const ProviderScope(
//           child: MaterialApp(
//             home: LoginView(),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//       await tester.enterText(find.byType(TextField).first, '1234@gmail.com');
//       await tester.enterText(find.byType(TextField).last, '123456');
//       await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//       await tester.pumpAndSettle();
//       expect(find.byType(SnackBar), findsOneWidget);
//     });
//   });
//   group("register test widget", () {
//     testWidgets('renders RegisterView from login page on click',
//         (tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(
//             home: const LoginView(),
//             routes: AppRoute.getApplication(), // Ensure routes are set
//           ),
//         ),
//       );
//       // Wait for the widgets to settle
//       await tester.pumpAndSettle();
//       // Tap the button with the specified key ("SignUpButton")
//       await tester.tap(find.byKey(const Key("SignUpButton")));
//       // Wait for the widgets to settle after the button tap
//       await tester.pumpAndSettle();
//       // Expect that the RegisterView is rendered
//       expect(find.byType(SignUpView), findsOneWidget);
//     });

//     testWidgets('renders RegisterView', (tester) async {
//       await tester.pumpWidget(
//         const ProviderScope(
//           child: MaterialApp(
//             home: SignUpView(),
//           ),
//         ),
//       );
//       // Expect that a Scaffold is rendered
//       expect(find.byType(Scaffold), findsOneWidget);
//       // Expect that the RegisterPage is rendered
//       expect(find.byType(SignUpView), findsOneWidget);
//     });
//   });
// }
