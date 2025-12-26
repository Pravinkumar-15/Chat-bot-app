import 'dart:convert';

import 'package:chat_app_flutter/services/chat_api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class _MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late ChatApiServices api;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    client = _MockHttpClient();
    api = ChatApiServices(client: client);
  });

  group('ChatApiServices.fetchComments', () {
    test('returns parsed comments when statusCode is 200', () async {
      final body = jsonEncode({
        'comments': [
          {
            'id': 1,
            'body': 'Hello',
            'postId': 10,
            'likes': 2,
            'user': {'id': 99, 'username': 'u1', 'fullName': 'User One'},
          },
        ],
      });

      when(
        () => client.get(any(), headers: null),
      ).thenAnswer((_) async => http.Response(body, 200));

      final result = await api.fetchComments(limit: 10);

      expect(result.length, 1);
      expect(result.first.id, 1);
      expect(result.first.body, 'Hello');
      expect(result.first.user.fullName, 'User One');

      verify(
        () => client.get(
          Uri.parse('https://dummyjson.com/comments?limit=10'),
          headers: null,
        ),
      ).called(1);
    });

    test('throws Exception when statusCode is not 200', () async {
      when(
        () => client.get(any(), headers: null),
      ).thenAnswer((_) async => http.Response('Server error', 500));

      expect(() => api.fetchComments(limit: 5), throwsA(isA<Exception>()));
    });

    test('throws when client throws', () async {
      when(
        () => client.get(any(), headers: null),
      ).thenThrow(Exception('No internet'));

      expect(() => api.fetchComments(), throwsA(isA<Exception>()));
    });
  });
}
