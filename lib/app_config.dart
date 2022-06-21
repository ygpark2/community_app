
enum Flavor {
  DEVELOPMENT,
  RELEASE,
}

class Config {
  static late Flavor appFlavor;

  static bool get isDebug {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return false;
      case Flavor.DEVELOPMENT:
      default:
        return true;
    }
  }
}
