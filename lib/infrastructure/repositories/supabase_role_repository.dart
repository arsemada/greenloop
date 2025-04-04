import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/role.dart';
import '../../domain/repositories/role_repository.dart';

class SupabaseRoleRepository implements RoleRepository {
  final SupabaseClient _supabaseClient;

  SupabaseRoleRepository(this._supabaseClient);

  @override
  Future<List<Role>> getAllRoles() async {
    final response = await _supabaseClient.from('rbac.roles').select();
    return (response as List).map((json) => Role.fromJson(json)).toList();
  }

  @override
  Future<List<Role>> getUserRoles(String userId) async {
    final response = await _supabaseClient
        .from('rbac.user_roles')
        .select('roles(*)')
        .eq('user_id', userId);
    return (response as List).map((item) => Role.fromJson(item['roles'])).toList();
  }

  @override
  Future<void> assignRole({required String userId, required int roleId}) async {
    await _supabaseClient.from('rbac.user_roles').insert({'user_id': userId, 'role_id': roleId});
  }

  @override
  Future<void> removeRole({required String userId, required int roleId}) async {
    await _supabaseClient
        .from('rbac.user_roles')
        .delete()
        .eq('user_id', userId)
        .eq('role_id', roleId);
  }
}