import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_state.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/snackbar_content.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainVideoBranch extends StatefulWidget {
  const MainVideoBranch({super.key});

  @override
  State<MainVideoBranch> createState() => _MainVideoBranchState();
}

class _MainVideoBranchState extends State<MainVideoBranch> {
  bool canPop = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool didPop) {
        setState(() {
          canPop = !didPop;
        });
      },
      child: BlocConsumer<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoLoadingState) {
            return const AppLoadingIndicator();
          }
          if (state is VideoResponseState) {
            return state.trailer.fold(
              (exceptionMessage) {
                return const Text("");
              },
              (response) {
                return AppVideoPlayer(
                  trailer: response.trailer,
                );
              },
            );
          }

          return Center(
            child: Text(AppLocalizations.of(context)!.state),
          );
        },
        listener: (context, state) {
          if (state is VideoResponseState) {
            state.trailer.fold(
              (exceptionMessage) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: SnackbarContent(
                      message: AppLocalizations.of(context)!.noDownloadLink,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    closeIconColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              (response) {},
            );
          }
        },
      ),
    );
  }
}

class AppVideoPlayer extends StatefulWidget {
  const AppVideoPlayer({super.key, required this.trailer});
  final String trailer;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.trailer),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: AspectRatio(
            aspectRatio: 16 / 8,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: FlickVideoPlayer(
                flickManager: flickManager,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
