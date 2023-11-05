import 'dart:io';

import 'package:impaktfull_cli/impaktfull_cli.dart';

import 'example_config.dart';

Future<void> main(List<String> arguments) async {
  await runImpaktfullCli(
    () async {
      final processRunner = CliProcessRunner();
      final testFlightPlugin = TestFlightPlugin(processRunner: processRunner);
      await testFlightPlugin.uploadToTestflightWithEmailPassword(
        filePath: File('app.ipa'),
        userName: ExampleConfig.appleEmailAdress,
        password: ExampleConfig.appleAppSpecificPassword,
      );
    },
    isVerboseLoggingEnabled: true,
  );
}
