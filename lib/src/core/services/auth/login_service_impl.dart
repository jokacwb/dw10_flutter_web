// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../repositories/auth/auth_repository.dart';
import '../../common/constants.dart';
import '../../storage/storage.dart';
import './login_service.dart';

class LoginServiceImpl implements LoginService {
  final AuthRepository _authRepository;
  final Storage _storage;

  LoginServiceImpl(
    this._authRepository,
    this._storage,
  );

  @override
  Future<void> execute(String email, String password) async {
    final authmodel = await _authRepository.login(email, password);
    _storage.setData(SessionStorageKeys.accessToken.key, authmodel.accessToken);
  }
}
