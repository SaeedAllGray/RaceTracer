import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/value_object/value_object_bloc.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';
import 'package:racetracer/src/presentation/widgets/rounded_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddValueObjectBottomSheet extends StatelessWidget {
  const AddValueObjectBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet(
        child: BlocProvider(
      create: (context) => ValueObjectBloc()..add(FetchServerScripts()),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                AppLocalizations.of(context)!.predefined_scripts,
                style: FontStyles.BLACK_BOLD_18,
              ),
            ),
            Expanded(
              child: BlocBuilder<ValueObjectBloc, ValueObjectState>(
                builder: (context, state) {
                  if (state is ValueObjectsFetched) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 0.3,
                      ),
                      itemCount: state.valueObjects.length + 1,
                      itemBuilder: (context, index) {
                        if (index != state.valueObjects.length) {
                          return ListTile(
                            leading: const Icon(Icons.code_rounded),
                            title: Text(
                              state.valueObjects[index].label!,
                              style: FontStyles.BLACK_MEDIUM_18,
                            ),
                            trailing: SizedBox(
                              height: 30,
                              width: 80,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDark,
                                    foregroundColor: AppColors.white,
                                    padding: EdgeInsets.zero),
                                child: Text(AppLocalizations.of(context)!.add),
                                onPressed: () {
                                  BlocProvider.of<ValueObjectBloc>(context).add(
                                      SaveScriptValueObject(
                                          valueObject:
                                              state.valueObjects[index]));
                                },
                              ),
                            ),
                          );
                        }
                        return ListTile(
                          leading: const Icon(Icons.insert_drive_file_rounded),
                          title: Text(
                            AppLocalizations.of(context)!.import_from_file,
                            style: FontStyles.BLACK_MEDIUM_18,
                          ),
                          trailing: SizedBox(
                            height: 30,
                            width: 80,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryDark,
                                  foregroundColor: AppColors.white,
                                  padding: EdgeInsets.zero),
                              child: Text(AppLocalizations.of(context)!.import),
                              onPressed: () {
                                BlocProvider.of<ValueObjectBloc>(context)
                                    .add(ImportFromFile());
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const LoadingWidget();
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
