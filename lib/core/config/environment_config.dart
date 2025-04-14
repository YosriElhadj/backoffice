enum Environment {
  development,
  staging,
  production
}

class EnvironmentConfig {
  static const Environment currentEnvironment = Environment.development;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.development:
        return 'https://dev-api.theboost.com';
      case Environment.staging:
        return 'https://staging-api.theboost.com';
      case Environment.production:
        return 'https://api.theboost.com';
    }
  }

  static bool get isDevelopment => 
    currentEnvironment == Environment.development;

  static bool get isProduction => 
    currentEnvironment == Environment.production;
}