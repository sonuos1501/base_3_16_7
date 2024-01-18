// ignore_for_file: avoid_dynamic_calls, inference_failure_on_function_invocation

import 'dart:convert';

import 'package:dio/dio.dart';

import '../custom_log/custom_log.dart';

abstract class Extrator {

  static String? getVideoId(String url) {
    try {
      var id = '';
      id = url.substring(url.indexOf('?v=') + '?v='.length);

      return 'https://www.youtube.com/watch?v=$id';
    } catch (e) {
      return null;
    }
  }

  static Future<List<String>> getVideoUrlFromYoutube(String youtubeUrl) async {
    // Extract the info url using the past method
    final link = getVideoId(youtubeUrl);

    // Checker if the link is valid
    if (link == null) {
      logError('Null Video Id from Link: $youtubeUrl');
      return [];
    }

    // Links Holder
    final links = <String>[]; // This could turn into a map if one desires it

    // Now make the request
    final networkClient = Dio();
    final response = await networkClient.get(link);

    // To make autocomplete easier
    final responseText = response.data.toString();

    // This sections the chuck of data into multiples so we can parse it
    final sections = Uri.decodeFull(responseText).split('&');

    // This is the response json we are looking for
    var playerResponse = <String, dynamic>{};

    // Optimized better
    for (var i = 0; i < sections.length; i++) {
        final s = sections[i];

        // We can have multiple '=' inside the json, we want to divide the chunk by only the first equal
        final firstEqual = s.indexOf('=');

        // Sanity Check
        if (firstEqual < 0) {
            continue;
        }

        // Here we create the key value of the chunk of data
        final key = s.substring(0, firstEqual);
        final value = s.substring(firstEqual + 1);

        // This is the key that holds the mp4 information
        if (key == 'player_response') {
            playerResponse = jsonDecode(value);
            break;
        }
    }

    // Now that we have the json we need, we can start pointing to the links that holds the mp4
    // The node we need
    final Map<String, dynamic> data = playerResponse['streamingData'];

    // Aggregating the data
    if (data['formats'] != null) {
      var formatLinks = <dynamic>[];
      formatLinks = data['formats'];
      for (final element in formatLinks) {
          // you can read the map here to get additional video infomation 
          // like quality width height and bitrate
          // For this example however I just want the url
          links.add(element['url']);
      }
    }

    // And adaptive ones also
    if (data['adaptiveFormats'] is List) {
      var formatLinks = <dynamic>[];
      formatLinks = data['adaptiveFormats'];
      for (final element in formatLinks) {
          // you can read the map here to get additional video infomation 
          // like quality width height and bitrate
          // For this example however I just want the url
          links.add(element['url']);
      }
    }

    // Finally return the links for the player
    return links.isNotEmpty
      ? links
      : ['<Holder Video>'];
        // This video Url will be the url we will use if there is an error with the method. Because we don't want to break do we? :)

}

}
