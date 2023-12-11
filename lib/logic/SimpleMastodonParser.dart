import 'package:flutter_simple_updates/flutter_simple_updates.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rss_dart/domain/rss_feed.dart';
import 'package:rss_dart/domain/rss_item.dart';

class SimpleMastodonParser extends AFeedParsingService {
  SimpleMastodonParser(super.trigger, super.id);

  @override
  Future<List<FeedEntryModel>> parseFeed() async {
    List<FeedEntryModel> feedEntryModels = [];
    Response resp = await http.get(Uri.parse("$id.rss"));
    if (resp.statusCode >= 300) {
      return [];
    } else {
      final rssFeed = RssFeed.parse(resp.body);
      for (RssItem item in rssFeed.items) {
        String cleanUpDescription = item.description!
            .replaceAll("<p>", "")
            .replaceAll("</p>",
                ""); // Needed to rm the p tags so we can check the contents
        if (cleanUpDescription.startsWith(trigger)) {
          DateFormat inputFormat = DateFormat('dd MMM yyyy hh:mm:ss +Z',
              "en_US"); // For reasons unknown, the local needs to be present for things to work (without it only works in the example app, idk why)
          String afterDayRm = item.pubDate!.split(", ")[1];
          DateTime dateTime = inputFormat.parse(afterDayRm);
          feedEntryModels.add(FeedEntryModel(cleanUpDescription,
              title: item.pubDate!,
              body: item.description!,
              source: item.link!,
              dateTime: dateTime));
        }
      }
      return feedEntryModels;
    }
  }
}
