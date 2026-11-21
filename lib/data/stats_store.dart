// lib/data/stats_store.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'offers_store.dart';
import 'skills_store.dart';

/// Average match score over time (oldest first, 30 points max).
final ValueNotifier<List<int>> scoreHistory = ValueNotifier<List<int>>([]);

Future<void> loadHistory() async {
  try {
    final r = await http.get(Uri.parse('$apiBase/snapshots'));
    if (r.statusCode == 200) {
      scoreHistory.value = (jsonDecode(r.body) as List)
          .map((e) => (e as num).toInt())
          .toList();
    }
  } catch (_) {
    // API offline: keep whatever is in memory
  }
}

/// Records a new point whenever skills or offers change the average score.
void startTracking() {
  void record() {
    final avg = averageScore(offers.value, mySkills.value);
    final h = scoreHistory.value;
    if (h.isNotEmpty && h.last == avg) return;

    final kept = h.length >= 30 ? h.sublist(h.length - 29) : h;
    scoreHistory.value = [...kept, avg];
    _post(avg);
  }

  mySkills.addListener(record);
  offers.addListener(record);
  record(); // first point
}

Future<void> _post(int score) async {
  try {
    await http.post(
      Uri.parse('$apiBase/snapshots'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'score': score}),
    );
  } catch (_) {
    // API offline: the point stays in memory only
  }
}
