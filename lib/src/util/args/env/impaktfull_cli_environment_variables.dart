import 'dart:io';

import 'package:impaktfull_cli/src/model/data/secret.dart';
import 'package:impaktfull_cli/src/model/error/impaktfull_cli_error.dart';

class ImpaktfullCliEnvironmentVariables {
  static const _envKeyCiKeyChainPassword = 'CI_KEYCHAIN_PASSWORD';
  static const _envKeyAppCenterOwnerName = 'APPCENTER_OWNER_NAME';
  static const _envKeyAppCenterToken = 'APPCENTER_API_TOKEN';

  const ImpaktfullCliEnvironmentVariables._();

  static void initSecrets() {
    _getUnlockKeyChainPassword();
  }

  static String? _getEnvVariable(String key) {
    final envVariables = Platform.environment;
    if (envVariables.containsKey(key)) return envVariables[key];
    return null;
  }

  static String _getNonOptionalEnvVariable(String key) {
    final value = String.fromEnvironment(key);
    if (value.isEmpty) {
      throw ImpaktfullCliError(
          '$_envKeyAppCenterOwnerName env variable is not set');
    }
    return value;
  }

  static Secret? _getEnvVariableSecret(String key) {
    final value = _getEnvVariable(key);
    if (value == null) return null;
    return Secret(value);
  }

  static Secret? _getUnlockKeyChainPassword() =>
      _getEnvVariableSecret(_envKeyCiKeyChainPassword);

  static Secret? _getAppCenterToken() =>
      _getEnvVariableSecret(_envKeyAppCenterToken);

  static String getAppCenterOwnerName() =>
      _getNonOptionalEnvVariable(_envKeyAppCenterOwnerName);

  static Secret getUnlockKeyChainPassword() {
    final secret = _getUnlockKeyChainPassword();
    if (secret == null) {
      throw ImpaktfullCliError(
          '$_envKeyCiKeyChainPassword env variable is not set');
    }
    return secret;
  }

  static Secret getAppCenterToken() {
    final secret = _getAppCenterToken();
    if (secret == null) {
      throw ImpaktfullCliError(
          '$_envKeyAppCenterToken env variable is not set');
    }
    return secret;
  }
}
