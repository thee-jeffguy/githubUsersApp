



import 'package:flutter/cupertino.dart';
import 'package:test_drive/domain/entities/user.dart';
import 'package:test_drive/domain/usecases/get_user_details_usecase.dart';

class UserDetailsProvider extends ChangeNotifier{
  late final GetUserDetailsUsecase getUserDetailsUsecase;

  User? _userDetails;
  bool _isLoading = false;
  String? _error;

  UserDetailsProvider(this.getUserDetailsUsecase);


  User? get userDetails  => _userDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future <void> getUserDetails(String login)async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userDetails = await getUserDetailsUsecase.call(login);
      _showUserDetails(userDetails);
    }catch (e) {
      _error = e.toString();
    }finally {
      _isLoading = false;
      notifyListeners();


    }

    }

    void _showUserDetails(User userDetails ){

    _userDetails = userDetails;
    notifyListeners();


  }






}