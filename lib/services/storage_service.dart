import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/metaphor_entry.dart';

class StorageService {
  static const _kEntries = 'entries';
  static const _kStreak = 'streak';
  static const _kLastEntryDate = 'last_entry_date';

  Future<List<MetaphorEntry>> loadEntries() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kEntries);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List)
        .map((e) => MetaphorEntry.fromJson(e))
        .toList();
    return list;
  }

  Future<void> saveEntries(List<MetaphorEntry> entries) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(
      _kEntries,
      jsonEncode(entries.map((e) => e.toJson()).toList()),
    );
  }

  Future<int> loadStreak() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(_kStreak) ?? 0;
  }

  Future<void> updateStreakOnSubmit(DateTime now) async {
    final sp = await SharedPreferences.getInstance();
    final last = sp.getString(_kLastEntryDate);
    final today = DateTime(now.year, now.month, now.day);
    if (last == null) {
      await sp.setInt(_kStreak, 1);
      await sp.setString(_kLastEntryDate, today.toIso8601String());
      return;
    }
    final lastDate = DateTime.parse(last);
    final diff = today.difference(lastDate).inDays;
    if (diff == 0) {
      return; // aynı gün: streak değişmez
    } else if (diff == 1) {
      final current = sp.getInt(_kStreak) ?? 0;
      await sp.setInt(_kStreak, current + 1);
    } else {
      await sp.setInt(_kStreak, 1); // sıfırla
    }
    await sp.setString(_kLastEntryDate, today.toIso8601String());
  }
}
