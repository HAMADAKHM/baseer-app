#!/usr/bin/env bash
# Installs Flutter + Android SDK on a fresh Linux machine/container.
# Idempotent: skips anything already present.
# Usage: ./scripts/setup_env.sh && source ~/.baseer_env
set -euo pipefail

FLUTTER_VERSION=3.47.8
CMDLINE_TOOLS=commandlinetools-linux-16111833_latest.zip
FLUTTER_DIR=/opt/flutter
ANDROID_HOME=/opt/android-sdk

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "Installing Flutter $FLUTTER_VERSION…"
  curl -fsSL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    | tar -xJ -C /opt
  git config --global --add safe.directory "$FLUTTER_DIR"
fi

if [ ! -x "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
  echo "Installing Android command-line tools…"
  mkdir -p "$ANDROID_HOME/cmdline-tools"
  tmp=$(mktemp -d)
  curl -fsSL -o "$tmp/tools.zip" "https://dl.google.com/android/repository/$CMDLINE_TOOLS"
  unzip -q "$tmp/tools.zip" -d "$tmp"
  mv "$tmp/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"
  rm -rf "$tmp"
fi

export ANDROID_HOME
export PATH="$FLUTTER_DIR/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

if [ ! -d "$ANDROID_HOME/platforms/android-36" ]; then
  yes | sdkmanager --licenses >/dev/null
  sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.1.0" >/dev/null
fi

flutter --disable-analytics >/dev/null 2>&1 || true
flutter config --android-sdk "$ANDROID_HOME" --no-enable-web --no-enable-linux-desktop >/dev/null 2>&1

cat > "$HOME/.baseer_env" <<ENV
export ANDROID_HOME=$ANDROID_HOME
export PATH="$FLUTTER_DIR/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:\$PATH"
ENV

cd "$(dirname "$0")/.." && flutter pub get >/dev/null
echo "Flutter $FLUTTER_VERSION and Android SDK ready. Run: source ~/.baseer_env"
