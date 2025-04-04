import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/admin.dart';
import '../../domain/repositories/admin_repository.dart';

class SupabaseAdminRepository implements AdminRepository {
  final SupabaseClient _supabaseClient;

  SupabaseAdminRepository(this._supabaseClient);

  @override
  Future<Admin?> getAdminProfile(String id) async {
    final response = await _supabaseClient
        .from('admins')
        .select()
        .eq('id', id)
        .maybeSingle();
    final authUser = await _supabaseClient.auth.getUser(id);
    return response == null ? null : Admin.fromJson(response..addAll({'id': id, 'email': authUser.user?.email}));
  }
}