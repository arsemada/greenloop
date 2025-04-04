import '../entities/role.dart';

abstract class RoleRepository {
  Future<List<Role>> getAllRoles();
  Future<List<Role>> getUserRoles(String userId);
  Future<void> assignRole({required String userId, required int roleId});
  Future<void> removeRole({required String userId, required int roleId});
}