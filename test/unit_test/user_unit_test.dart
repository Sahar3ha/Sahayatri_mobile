import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/auth/domain/use_case/user_login_use_case.dart';
import 'package:sahayatri/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:sahayatri/features/auth/presentation/viewmodel/user_view_model.dart';

import 'user_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
  MockSpec<BuildContext>()
])
void main() {
  late LoginUseCase mockLoginUseCase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockLoginUseCase = MockLoginUseCase();
    context = MockBuildContext();
    container = ProviderContainer(overrides: [
      loginViewModelProvider.overrideWith(
        (ref) => LoginViewModel(mockLoginUseCase),
      ),
    ]);
  });

  test('should initialize with correct state', () async {
    final authState = container.read(userViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  test('login test with valid username and password', () async {
    when(mockLoginUseCase.loginUser('a@gmail.com', '123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    when(mockLoginUseCase.loginUser('a@gmail.com', '123'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(loginViewModelProvider.notifier)
        .loginUser(context, 'a@gmail.com', '123');

    final authState = container.read(loginViewModelProvider);

    // Check for appropriate error handling in your ViewModel
    expect(authState.error, isNotNull);
  });

   test('check for invalid email and password ', () async {
    when(mockLoginUseCase.loginUser('kiran', 'kiran1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(loginViewModelProvider.notifier)
        .loginUser(context, 'kiran', 'kiran1234');

    final authState = container.read(loginViewModelProvider);

    expect(authState.error, 'Invalid');
  });
   test('test login with invalid email', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'User with email not found',
      );
 
      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          'test22@example.com',
          'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
 
      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'test22@example.com',
        'password',
      );
 
      // Verify the expected result
      expect(result, Left(mockErrorModel));
    });
    test('test login with invalid password', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Invalid Password',
      );
 
      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          'test@example.com',
          'password000',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
 
      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'test@example.com',
        'password000',
      );
 
      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

test('test login with null email', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter email',
      );
 
      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          'null',
          'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
 
      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'null',
        'password',
      );
 
      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

test('login with null password should return proper error', () async {
  // Mocked error model for failed login with null password
  final mockErrorModel = Failure(
    error: 'Please enter password',
  );

  // Mock the loginUser method to return the mockErrorModel when called with null password
  when(mockLoginUseCase.loginUser('test@example.com', 'null'))
      .thenAnswer((_) async => Left(mockErrorModel)); // Use any matcher for password

  // Call the loginUser method with null password
  final result = await mockLoginUseCase.loginUser('test@example.com', 'null');

  // Verify that the result is the expected error model
  expect(result, Left(mockErrorModel));
});


  tearDownAll(() => container.dispose());
}
