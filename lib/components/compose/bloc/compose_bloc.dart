import 'package:dart_twitter_api/twitter_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harpy/components/compose/bloc/compose_event.dart';
import 'package:harpy/components/compose/bloc/compose_state.dart';
import 'package:harpy/core/service_locator.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeBloc() : super(InitialComposeTweetState());

  final TweetService tweetService = app<TwitterApi>().tweetService;

  static ComposeBloc of(BuildContext context) => context.watch<ComposeBloc>();

  /// The selected media to be attached to the tweet.
  List<PlatformFile> media = <PlatformFile>[];

  /// Whether media has been attached to the tweet.
  bool get hasMedia => media.isNotEmpty;

  /// Whether the media only contains images.
  bool get hasImages => media.every(
        (PlatformFile file) => findMediaType(file.path) == MediaType.image,
      );

  /// Whether the media contains a single gif.
  bool get hasGif =>
      media.length == 1 && findMediaType(media.first.path) == MediaType.gif;

  /// Whether the media contains a single video.
  bool get hasVideo =>
      media.length == 1 && findMediaType(media.first.path) == MediaType.video;

  @override
  Stream<ComposeState> mapEventToState(
    ComposeEvent event,
  ) async* {
    yield* event.applyAsync(currentState: state, bloc: this);
  }
}
