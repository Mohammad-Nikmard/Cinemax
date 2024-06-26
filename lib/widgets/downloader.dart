import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/snackbar_content.dart';
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
            (response) {
              Navigator.pop(context);
              FileDownloader.downloadFile(
                notificationType: (AppManager.getNotif() == true)
                    ? NotificationType.all
                    : NotificationType.disabled,
                url: response.trailer,
                name: response.name,
                onDownloadError: (String error) {
                  SnackBar(
                    content: SnackbarContent(
                      message:
                          '${AppLocalizations.of(context)!.downloadError} $error',
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
                SnackBar(
                  content: SnackbarContent(
                    message: AppLocalizations.of(context)!.downloadMessage,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  closeIconColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          );
        }
      },
    );
  }
}
