_AUDIO_OPTS="--device /dev/snd"
_DISPLAY_OPTS="-e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix"
# WSL2
if uname -a | grep -q "microsoft" ; then
  _AUDIO_OPTS="-e PULSE_SERVER=$PULSE_SERVER -v /mnt/wslg/:/mnt/wslg/"
fi

_DOCKER_OPTS="$_AUDIO_OPTS $_DISPLAY_OPTS"

if [ ! -z "$VICE_CFG" ] ; then
  _DOCKER_OPTS="$_DOCKER_OPTS -v $VICE_CFG:/root/.vicerc"
fi
if [ ! -z "$VICE_CWD" ] ; then
  _DOCKER_OPTS="$_DOCKER_OPTS -v $VICE_CWD:/usr/local/lib/vice"
  _VICE_OPTS="$_VICE_OPTS -chdir /usr/local/lib/vice"
fi

# Run a VICE emulator
# Usage: run_emulator [emulator] [options]
run_emulator() {
  _emulator="$1"; shift; _options="$@"
  _VICE_OPTS="$_VICE_OPTS $_options"
  docker run -it --rm $_DOCKER_OPTS vice:3.8 /bin/sh -c "/usr/local/bin/${_emulator} ${_VICE_OPTS}"
}