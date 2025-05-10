import 'package:realstate/models/UpdateUserSpeceficDetails.dart';
import 'package:realstate/models/UserModel.dart';


abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  UserLoaded(this.users);
}

class UserError extends UserState {
  final String error;
  UserError(this.error);
}


class UserUpdated extends UserState {  // updating name and email state 
  final UpdateUserSpeceficDetails updatedUser;

  UserUpdated(this.updatedUser);
}


class AddUSer extends UserState{
final AddUSer adduser;

AddUSer(this.adduser);

}


class UserDeletedSuccessfully extends UserState {


}

class UseraddedSuccessfully extends UserState {
 
}


