
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl =
      'https://isorcayqpifovddlhwht.supabase.co';

  static const String supabasePublishableKey =
      'sb_publishable_7qhj9_TydXIlcsnqIFl_IQ_6o8GGH80';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabasePublishableKey,
    );
  }
}
