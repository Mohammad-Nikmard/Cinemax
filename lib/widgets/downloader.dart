import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDownloader extends StatelessWidget {
  const AppDownloader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoLoadingState) {
          return const AppLoadingIndicator();
        } else if (state is VideoResponseState) {
          return state.trailer.fold(
            (exceptionMessage) {
              return const Text("");
            },
            (response) {
              return const Text("");
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
            (response) {
              Navigator.pop(context);
              FileDownloader.downloadFile(
                notificationType: NotificationType.all,
                url: response.trailer,
                name: response.name,
                onDownloadError: (String error) {
                  SnackBar(
                    content: DownloadingMessage(
                      message: 'DOWNLOAD ERROR: $error',
                      color: SecondaryColors.orangeColor,
                    ),
                    closeIconColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    duration: const Duration(seconds: 3),
                  );
                },
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: DownloadingMessage(
                    message: "Trailer is added to download list.",
                    color: SecondaryColors.greenColor,
                  ),
                  closeIconColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  duration: Duration(seconds: 3),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class DownloadingMessage extends StatelessWidget {
  const DownloadingMessage(
      {super.key, required this.color, required this.message});
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHandler.screenWidth(context),
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(right: 15, left: 15),
        child: Center(
          child: Text(
            "Trailer is added to download list.",
            style: TextStyle(
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
