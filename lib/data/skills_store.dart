// lib/data/skills_store.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';

/// The user's skills (names). Any screen can listen to it.
final ValueNotifier<List<String>> mySkills = ValueNotifier<List<String>>([]);

/// Level of each skill: 1 = beginner, 2 = intermediate, 3 = advanced.
final Map<String, int> _levels = {};

const levelNames = {1: 'Beginner', 2: 'Intermediate', 3: 'Advanced'};

int levelOf(String name) => _levels[name.toLowerCase()] ?? 2;

const _json = {'Content-Type': 'application/json'};

Future<void> loadSkills() async {
  try {
    final r = await http.get(Uri.parse('$apiBase/skills'));
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body) as List;
      _levels.clear();
      final names = <String>[];
      for (final e in data) {
        final name = e is Map ? e['name'] as String : e as String;
        final level = e is Map ? (e['level'] as num?)?.toInt() ?? 2 : 2;
        names.add(name);
        _levels[name.toLowerCase()] = level;
      }
      mySkills.value = names;
    }
  } catch (_) {
    // API offline: keep whatever is in memory
  }
}

void addSkill(String name, [int level = 2]) {
  final skill = name.trim();
  if (skill.isEmpty) return;

  final exists = mySkills.value.any(
    (s) => s.toLowerCase() == skill.toLowerCase(),
  );
  if (exists) return;

  _levels[skill.toLowerCase()] = level;
  mySkills.value = [...mySkills.value, skill];
  _send(() => http.post(
        Uri.parse('$apiBase/skills'),
        headers: _json,
        body: jsonEncode({'name': skill, 'level': level}),
      ));
}

void removeSkill(String name) {
  _levels.remove(name.toLowerCase());
  mySkills.value = mySkills.value.where((s) => s != name).toList();
  _send(() => http.delete(
        Uri.parse('$apiBase/skills/${Uri.encodeComponent(name)}'),
      ));
}

void setSkillLevel(String name, int level) {
  _levels[name.toLowerCase()] = level;
  // new list instance so every screen listening to mySkills rebuilds
  mySkills.value = [...mySkills.value];
  _send(() => http.put(
        Uri.parse('$apiBase/skills/${Uri.encodeComponent(name)}'),
        headers: _json,
        body: jsonEncode({'level': level}),
      ));
}

Future<void> _send(Future<http.Response> Function() request) async {
  try {
    await request();
  } catch (_) {
    // API offline: the change stays in memory only
  }
}