import '../entities/admin.dart';

abstract class AdminRepository {
  Future<Admin?> getAdminProfile(String id);
}