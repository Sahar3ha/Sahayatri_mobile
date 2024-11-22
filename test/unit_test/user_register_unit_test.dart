import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';
import 'package:sahayatri/features/auth/domain/use_case/add_user_usecase.dart';

import 'user_register_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AddUserUseCase>(), MockSpec<BuildContext>()])
void main() {
  late MockAddUserUseCase mockAddUserUseCase;
  setUpAll(() async {
    mockAddUserUseCase = MockAddUserUseCase();
  });

  group("register test", () {
    setUp(() {
      when(mockAddUserUseCase.registerUser(const UserEntity(
              firstName: "test",
              lastName: "est",
              email: "test@email.com",
              password: "123")))
          .thenAnswer((_) async => const Right(true));
    });

    test('test signup with proper credential', () async {
      final result = await mockAddUserUseCase.registerUser(const UserEntity(
          firstName: "test",
          lastName: "est",
          email: "test@email.com",
          password: "123"));
      expect(result, const Right(true));
    });


    test('test signup with invalid credentials', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter valid email',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockAddUserUseCase.registerUser(const UserEntity(
          email: 'test@example.com',
          password: 'password',
          firstName: 'Test1',
          lastName: 'User1',
        )),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockAddUserUseCase.registerUser(const UserEntity(
        email: 'test@example.com',
        password: 'password',
        firstName: 'Test1',
        lastName: 'User1',
      ));

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });
  });
  test('test signup with no credentials', () async {
    /// Creating a proper mock failure for failed login with invalid email
    final mockErrorModel = Failure(
      error: 'Please enter email',
    );

    /// if provided certain credential returen the mockErrorModel
    when(
      mockAddUserUseCase.registerUser(const UserEntity(
        email: 'null',
        password: 'null',
        firstName: 'null',
        lastName: 'null',
      )),
    ).thenAnswer(
      (_) async => Left(mockErrorModel),
    );
    // Call the login method
    final result = await mockAddUserUseCase.registerUser(const UserEntity(
      email: 'null',
      password: 'null',
      firstName: 'null',
      lastName: 'null',
    ));

    // Verify the expected result
    expect(
      result,
      Left(mockErrorModel),
    );
  });
  test('sign up with no username and password should return proper error', () async {
  // Mocked error model for failed sign up with missing credentials
  final mockErrorModel = Failure(
    error: 'Please enter first name, last name, email, and password',
  );

  // Mock the registerUser method to return the mockErrorModel when called with null or empty strings for first name, last name, email, and password
  when(mockAddUserUseCase.registerUser(const UserEntity(
    email: '',
    password: 'password',
    firstName: '',
    lastName: 'last name',
  ))).thenAnswer((_) async => Left(mockErrorModel));

  // Call the registerUser method with null or empty strings for first name, last name, email, and password
  final result = await mockAddUserUseCase.registerUser(const UserEntity(
    email: '',
    password: 'password',
    firstName: '',
    lastName: 'last name',
  ));

  // Verify that the result is the expected error model
  expect(result, Left(mockErrorModel));
});

}
