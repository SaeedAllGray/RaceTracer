import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/application/attribute_diff/attribute_diff_bloc.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class NewTestSessionPage extends StatelessWidget {
  static const routeName = '/new_session_page';

  const NewTestSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttributeDiffBloc()..add(GetAttributeDiffs()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.documentation),
        ),
        body: BlocBuilder<AttributeDiffBloc, AttributeDiffState>(
          builder: (context, state) {
            if (state is AttributeDiffsFetched) {
              return ListView.builder(
                  itemCount: state.attributeDiffs.length,
                  itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.lightGrey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.all(3),
                              // margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                state.attributeDiffs[index].attribute,
                                style: FontStyles.BLACK_MEDIUM_16,
                              ),
                            ),
                            const Text(
                              ":",
                              style: FontStyles.BLACK_MEDIUM_16,
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.warning.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.all(3),
                              // margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                state.attributeDiffs[index].oldValue.toString(),
                                style: FontStyles.BLACK_MEDIUM_16,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_right_alt_rounded,
                              color: AppColors.blueGrey,
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.newChanges.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.all(3),
                              // margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                state.attributeDiffs[index].oldValue.toString(),
                                style: FontStyles.BLACK_MEDIUM_16,
                              ),
                            ),
                          ],
                        ),
                      ));
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
