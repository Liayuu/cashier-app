import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._internal();

  factory LocalDatabase() => instance;

  LocalDatabase._internal();

  final Map<String, Map<String, Map<String, dynamic>>> _store = {};
  File? _file;

  Future<void> _ensureFile() async {
    if (_file != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _file = File('${dir.path}/local_db.json');
    if (await _file!.exists()) {
      try {
        final content = await _file!.readAsString();
        if (content.isNotEmpty) {
          final decoded = json.decode(content) as Map<String, dynamic>;
          decoded.forEach((col, docs) {
            _store[col] = {};
            (docs as Map<String, dynamic>).forEach((id, doc) {
              _store[col]![id] = Map<String, dynamic>.from(doc as Map);
            });
          });
        }
      } catch (_) {}
    } else {
      await _file!.create(recursive: true);
      await _file!.writeAsString('{}');
    }
  }

  Future<void> _persist() async {
    await _ensureFile();
    final out = _store.map((col, docs) => MapEntry(col, docs));
    await _file!.writeAsString(json.encode(out));
  }

  Future<List<Map<String, dynamic>>> getCollection(String name) async {
    await _ensureFile();
    final docs = _store[name];
    if (docs == null) return [];
    return docs.entries.map((e) => {...e.value, 'id': e.key}).toList();
  }

  Future<Map<String, dynamic>?> getDocument(
      String collection, String id) async {
    await _ensureFile();
    final docs = _store[collection];
    if (docs == null) return null;
    final doc = docs[id];
    if (doc == null) return null;
    return {...doc, 'id': id};
  }

  Future<String> addDocument(
      String collection, Map<String, dynamic> data) async {
    await _ensureFile();
    _store.putIfAbsent(collection, () => {});
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _store[collection]![id] = Map<String, dynamic>.from(data);
    await _persist();
    return id;
  }

  Future<void> updateDocument(
      String collection, String id, Map<String, dynamic> data) async {
    await _ensureFile();
    _store.putIfAbsent(collection, () => {});
    _store[collection]![id] = Map<String, dynamic>.from(data);
    await _persist();
  }

  Future<void> deleteDocument(String collection, String id) async {
    await _ensureFile();
    _store.putIfAbsent(collection, () => {});
    _store[collection]!.remove(id);
    await _persist();
  }

  Future<List<Map<String, dynamic>>> whereEquals(
      String collection, String field, dynamic value) async {
    final all = await getCollection(collection);
    return all.where((d) => d[field] == value).toList();
  }

  Future<List<Map<String, dynamic>>> whereArrayContains(
      String collection, String field, dynamic value) async {
    final all = await getCollection(collection);
    return all
        .where((d) => (d[field] as List?)?.contains(value) ?? false)
        .toList();
  }

  Future<List<Map<String, dynamic>>> whereIn(
      String collection, String field, List<dynamic> values) async {
    final all = await getCollection(collection);
    return all
        .where((d) =>
            values.contains(d[field]) ||
            (d[field] is List &&
                (d[field] as List).any((e) => values.contains(e))))
        .toList();
  }

  Future<List<Map<String, dynamic>>> whereGreaterThanOrEqual(
      String collection, String field, Comparable value) async {
    final all = await getCollection(collection);
    return all.where((d) {
      final v = d[field];
      if (v is Comparable) return v.compareTo(value) >= 0;
      return false;
    }).toList();
  }

  Future<void> setMeta(String key, Map<String, dynamic> data) async {
    await _ensureFile();
    _store.putIfAbsent('_meta', () => {});
    _store['_meta']![key] = Map<String, dynamic>.from(data);
    await _persist();
  }

  Future<Map<String, dynamic>?> getMeta(String key) async {
    await _ensureFile();
    final meta = _store['_meta'];
    if (meta == null) return null;
    return meta[key] == null ? null : Map<String, dynamic>.from(meta[key]!);
  }

  // Convenience transaction helpers to match previous API used by controllers
  Future<List<Map<String, dynamic>>> getTransactions(
      {required String merchantId,
      required String locationId,
      DateTime? sinceDate}) async {
    final coll = (await getCollection('transaction'))
        .where((d) =>
            (d['merchantId'] == merchantId) &&
            ((d['locationId'] == locationId) ||
                ((d['locationId'] is List) &&
                    (d['locationId'] as List).contains(locationId))))
        .toList();
    if (sinceDate != null) {
      return coll.where((d) {
        final created = d['createdAt'];
        if (created is String) {
          final dt = DateTime.tryParse(created);
          if (dt == null) return true;
          return dt.isAfter(sinceDate) || dt.isAtSameMomentAs(sinceDate);
        } else if (created is int) {
          final dt = DateTime.fromMillisecondsSinceEpoch(created);
          return dt.isAfter(sinceDate) || dt.isAtSameMomentAs(sinceDate);
        } else if (created is DateTime) {
          return created.isAfter(sinceDate) ||
              created.isAtSameMomentAs(sinceDate);
        }
        return true;
      }).toList();
    }
    return coll;
  }

  Future<Map<String, dynamic>?> getTransactionById(String id) async {
    return await getDocument('transaction', id);
  }

  Future<String> addTransaction(Map<String, dynamic> data) async {
    return await addDocument('transaction', data);
  }
}
