import 'package:impaktfull_cli/impaktfull_cli.dart';

import 'config.dart';

Future<void> main(List<String> arguments) async {
  await runImpaktfullCli(
    () async {
      final keyChainPlugin = MacOsKeyChainPlugin();
      final keyChainName = Config.keyChainName;
      final globalKeyChainPasswordSecret = Config.globalKeyChainPassword;

      await keyChainPlugin.printKeyChainList();
      await keyChainPlugin.createKeyChain(
          keyChainName, globalKeyChainPasswordSecret);
      await keyChainPlugin.printKeyChainList();
      await keyChainPlugin.unlockKeyChain(
          keyChainName, globalKeyChainPasswordSecret);

      ImpaktfullCliLogger.debug('Execute build');
      await Future.delayed(const Duration(seconds: 5));

      await keyChainPlugin.printKeyChainList();
      await keyChainPlugin.removeKeyChain(keyChainName);
      await keyChainPlugin.printKeyChainList();
    },
    isVerboseLoggingEnabled: true,
  );
}
