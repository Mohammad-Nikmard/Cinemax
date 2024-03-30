import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainVideoBranch extends StatelessWidget {
  const MainVideoBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoState>(
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
                const SnackBar(
                  content: NoLinkSnackBar(),
                  closeIconColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            (response) {},
          );
        }
      },
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: AspectRatio(
          aspectRatio: 16 / 7,
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
    );
  }
}

class NoLinkSnackBar extends StatelessWidget {
  const NoLinkSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHandler.screenWidth(context),
      height: 60,
      decoration: const BoxDecoration(
        color: SecondaryColors.redColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noDownloadLink,
            style: const TextStyle(
              color: TextColors.whiteText,
              fontSize: 12,
              fontFamily: "MSB",
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
