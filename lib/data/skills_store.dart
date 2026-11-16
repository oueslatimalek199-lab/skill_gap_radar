// lib/data/skills_store.dart
import 'package:flutter/foundation.dart';

/// The user's skills. Any screen can listen to it.
final ValueNotifier<List<String>> mySkills = ValueNotifier<List<String>>([]);

void addSkill(String name) {
  final skill = name.trim();
  if (skill.isEmpty) return;

  final exists = mySkills.value.any(
    (s) => s.toLowerCase() == skill.toLowerCase(),
  );
  if (exists) return;

  mySkills.value = [...mySkills.value, skill];
}

void removeSkill(String name) {
  mySkills.value = mySkills.value.where((s) => s != name).toList();
}