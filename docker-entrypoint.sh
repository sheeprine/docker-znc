#!/usr/bin/env sh

# Options.
DATADIR="/znc-data"

# Build modules from source.
if [ -d "${DATADIR}/modules" ]; then
  cd "${DATADIR}/modules"
  find . -name "*.cpp" -exec znc-buildmod {} \;
fi

# Create default config if it doesn't exist
if [ ! -f "${DATADIR}/configs/znc.conf" ]; then
  echo "Creating a default configuration..."
  mkdir -p "${DATADIR}/configs"
  cp /znc.conf.default "${DATADIR}/configs/znc.conf"
fi

# Make sure $DATADIR is owned by znc user. This effects ownership of the
# mounted directory on the host machine too.
echo "Setting necessary permissions..."
chown -R znc:znc "$DATADIR"

# Start ZNC.
echo "Starting ZNC..."
exec sudo -u znc znc --foreground --datadir="$DATADIR" $@
