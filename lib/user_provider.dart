import 'package:flutter/material.dart';

/// ==========================
/// USER MODEL
/// ==========================
class UserData {
  final String username;
  final String email;
  final String password;
  final String role;

  UserData({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  UserData copyWith({
    String? username,
    String? email,
    String? password,
    String? role,
  }) {
    return UserData(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}

/// ==========================
/// INHERITED WIDGET (STATE ACCESS)
/// ==========================
class UserProvider extends InheritedWidget {
  final UserData? user;

  final Function(UserData) registerUser;
  final Function(String email, String password) loginUser;
  final Function() logoutUser;

  const UserProvider({
    super.key,
    required this.user,
    required this.registerUser,
    required this.loginUser,
    required this.logoutUser,
    required super.child,
  });

  /// Access helper
  static UserProvider of(BuildContext context) {
    final provider =
    context.dependOnInheritedWidgetOfExactType<UserProvider>();

    if (provider == null) {
      throw FlutterError("UserProvider not found in widget tree");
    }

    return provider;
  }

  /// rebuild only when user changes
  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return oldWidget.user != user;
  }
}

/// ==========================
/// STATE CONTAINER (LOGIC + RBAC)
/// ==========================
class UserStore extends StatefulWidget {
  final Widget child;

  const UserStore({super.key, required this.child});

  @override
  State<UserStore> createState() => _UserStoreState();
}

class _UserStoreState extends State<UserStore> {
  UserData? _user;

  /// --------------------------
  /// ADMIN ACCOUNT (RBAC BASE)
  /// --------------------------
  final UserData _admin = UserData(
    username: "Admin",
    email: "admin@gmail.com",
    password: "admin123",
    role: "admin",
  );

  /// normal users list
  final List<UserData> _users = [];

  /// ==========================
  /// REGISTER (DEFAULT ROLE = USER)
  /// ==========================
  void _register(UserData user) {
    final newUser = user.copyWith(role: "user");

    setState(() {
      _users.add(newUser);
      _user = newUser;
    });
  }

  /// ==========================
  /// LOGIN (RBAC LOGIC)
  /// ==========================
  void _login(String email, String password) {
    // 🔐 ADMIN CHECK FIRST
    if (email == _admin.email && password == _admin.password) {
      setState(() {
        _user = _admin;
      });
      return;
    }

    // 🔍 NORMAL USER CHECK
    final matchedUser = _users.where(
          (u) => u.email == email && u.password == password,
    );

    if (matchedUser.isNotEmpty) {
      setState(() {
        _user = matchedUser.first;
      });
    } else {
      setState(() {
        _user = null;
      });
    }
  }

  /// ==========================
  /// LOGOUT
  /// ==========================
  void _logout() {
    setState(() {
      _user = null;
    });
  }

  /// ==========================
  /// RBAC HELPERS
  /// ==========================
  bool get isLoggedIn => _user != null;

  bool get isAdmin => _user?.role == "admin";

  bool get isUser => _user?.role == "user";

  bool canAccessAdminPanel() => isAdmin;

  bool canAccessHome() => isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      user: _user,
      registerUser: _register,
      loginUser: _login,
      logoutUser: _logout,
      child: widget.child,
    );
  }
}