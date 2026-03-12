class AuthRepository{
  Future<bool> register(String email, String password)
  {
    Future.delayed(Duration(seconds: 2));
    return Future.value(true);
  }
}