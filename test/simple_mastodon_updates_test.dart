import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:simple_mastodon_updates/logic/SimpleMastodonParser.dart';

void main() {
  setUpAll(() => nock.init());
  group('SimpleMastodonParser', () {
    final file = File("fixtures/@Decentproof.rss");
    test('parseFeed if trigger included', () async {
      final SimpleMastodonParser simpleMastodonParser =
          SimpleMastodonParser("!", "https://mastodon.social/@1");
      String content = await file.readAsString();
      final interceptor = nock('https://mastodon.social').get('/@1.rss')
        ..reply(200, content);
      final entries = await simpleMastodonParser.parseFeed();
      expect(entries.length, 1);
      expect(interceptor.isDone, true);
    });
    test("return nothing if no trigger", () async {
      final SimpleMastodonParser simpleMastodonParser =
          SimpleMastodonParser(">", "https://mastodon.social/@1");
      String content = await file.readAsString();
      final interceptor = nock('https://mastodon.social').get('/@1.rss')
        ..reply(200, content);
      final entries = await simpleMastodonParser.parseFeed();
      expect(entries.length, 0);
      expect(interceptor.isDone, true);
    });
    test("if error return empty array", () async {
      final SimpleMastodonParser simpleMastodonParser =
          SimpleMastodonParser("!", "https://mastodon.social/@1");
      final interceptor = nock('https://mastodon.social').get('/@1.rss')
        ..reply(500, "Internal Server Error");
      final entries = await simpleMastodonParser.parseFeed();
      expect(entries.length, 0);
      expect(interceptor.isDone, true);
    });
  });
}
