import 'package:firebase_auth/firebase_auth.dart';

///User Change Listen Event
///Display Name Change Event
///Password Update Event
///Sign Out Event
abstract class HomeBaseEvent {
  const HomeBaseEvent();
}

class UserChangedEvent extends HomeBaseEvent {
  final User user;

  const UserChangedEvent(this.user);
}

class DisplayNameChangeEvent extends HomeBaseEvent {
  final String displayName;

  const DisplayNameChangeEvent(this.displayName);
}

class PasswordUpdateEvent extends HomeBaseEvent {
  final String password;

  const PasswordUpdateEvent(this.password);
}

class SignOutEvent extends HomeBaseEvent {
  const SignOutEvent();
}
