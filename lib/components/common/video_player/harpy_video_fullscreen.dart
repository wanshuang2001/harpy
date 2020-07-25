import 'package:flutter/material.dart';
import 'package:harpy/components/common/video_player/harpy_video_player_model.dart';
import 'package:harpy/components/common/video_player/harpy_video_player_overlay.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

/// Builds the video for the [model].
///
/// Used by the [HarpyVideoPlayerModel] to build the a [HarpyVideoPlayer] in
/// fullscreen.
class HarpyVideoFullscreen extends StatelessWidget {
  const HarpyVideoFullscreen(this.model);

  final HarpyVideoPlayerModel model;

  Widget _buildVideo() {
    return Hero(
      tag: model.controller.dataSource,
      child: Stack(
        children: <Widget>[
          VideoPlayer(model.controller),
          VideoPlayerOverlay(model),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: model.controller.value.aspectRatio,
        child: ChangeNotifierProvider<HarpyVideoPlayerModel>.value(
          value: model,
          child: _buildVideo(),
        ),
      ),
    );
  }
}