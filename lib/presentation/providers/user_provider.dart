import 'package:flutter/cupertino.dart';
import 'package:test_drive/domain/entities/user.dart';
import 'package:test_drive/domain/usecases/search_by_username_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';

class UserProvider extends ChangeNotifier {
  late final GetUsersUsecase getUsersUsecase;
  late final SearchUsersByUsernameUsecase searchUsersByUsernameUsecase;

  List<User> _users = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isLoading = false;

  UserProvider(this.getUsersUsecase, this.searchUsersByUsernameUsecase);

  List<User> get users => _users;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  void resetSearchState() {
    _users = [];
    _currentPage = 1;
    _isLoadingMore = false;
    _hasMore = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUsers(String? location, int page) async {
    try {
      final fetchedUsers = await getUsersUsecase.execute(location, page);

      if (page == 1) {
        _users = fetchedUsers.map(_mapUser).toList();
      } else {
        _users.addAll(fetchedUsers.map(_mapUser).toList());
      }

      if (fetchedUsers.isEmpty) {
        _hasMore = false;
      }

      notifyListeners();
    } catch (e) {
      print('Failed to fetch users: $e');
    }
  }

  User _mapUser(User user) {
    return User(
      login: user.login ?? 'N/A',
      name: user.name ?? 'Unknown',
      avatarUrl: user.avatarUrl ?? 'data:image/jpeg;base64,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',
      bio: user.bio ?? 'No bio available',
      type: user.type ?? 'User',
    );
  }

  Future<void> loadMoreUsers(String? location) async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    await getUsers(location, _currentPage);

    _isLoadingMore = false;
    _currentPage++;
    notifyListeners();
  }

  Future<void> searchUsersByUsername(String? username, int page) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedUsers = await searchUsersByUsernameUsecase.execute(username, page);
      if (page == 1) {
        _users = fetchedUsers.map(_mapUser).toList();
      } else {
        _users.addAll(fetchedUsers.map(_mapUser).toList());
      }

      if (fetchedUsers.isEmpty) {
        _hasMore = false;
      }

      notifyListeners();
    } catch (e) {
      print('Failed to search users: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreUsersByUsername(String? username) async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    await searchUsersByUsername(username, _currentPage);

    _isLoadingMore = false;
    _currentPage++;
    notifyListeners();
  }
}
