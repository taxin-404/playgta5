#!/usr/bin/env bash
# Linux/macOS launcher: same job as Launch-Local.cmd, but with a system Python
# (the bundled runtime/ is a Windows-only embeddable Python).
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d mirror/playgta5.com ]; then
	echo "Game data not found: mirror/playgta5.com/" >&2
	echo "Put your mirror folder there (~21 GB), or download it with:" >&2
	echo "    python3 mirror_site.py" >&2
	exit 1
fi

if command -v python3 >/dev/null 2>&1; then
	PYTHON=python3
elif command -v python >/dev/null 2>&1; then
	PYTHON=python
else
	echo "Python 3.11+ is required but none was found on PATH." >&2
	exit 1
fi

"$PYTHON" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 11) else sys.exit("Python 3.11+ required, found " + sys.version.split()[0]))'

# The engine needs WebGPU: Firefox on Linux cannot run it, so open a
# Chromium-based browser with WebGPU/Vulkan enabled instead of the
# default browser (serve_local.py --open would pick Firefox).
PORT=8000
args=()
while [ $# -gt 0 ]; do
	case "$1" in
		--port)
			PORT="$2"; args+=("$1" "$2"); shift 2 ;;
		--port=*)
			PORT="${1#--port=}"; args+=("$1"); shift ;;
		*)
			args+=("$1"); shift ;;
	esac
done
URL="http://localhost:${PORT}/"

BROWSER=""
if [ -n "${PLAYGTA5_BROWSER:-}" ]; then
	BROWSER="$PLAYGTA5_BROWSER"
else
	for candidate in chromium chromium-browser google-chrome google-chrome-stable chrome \
			"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; do
		if command -v "$candidate" >/dev/null 2>&1 || [ -x "$candidate" ]; then
			BROWSER="$candidate"
			break
		fi
	done
fi

if [ -z "$BROWSER" ]; then
	# No Chromium found: fall back to the default browser (may not support WebGPU).
	exec "$PYTHON" serve_local.py --open --port "$PORT" ${args[@]+"${args[@]}"}
fi

# Isolated profile so the WebGPU flags always apply even if another
# Chromium with a different profile is already running.
PROFILE="${XDG_CACHE_HOME:-$HOME/.cache}/playgta5/chrome-profile"
mkdir -p "$PROFILE"

# Wait for the server to accept connections, then open the game.
(
	for _ in $(seq 1 100); do
		"$PYTHON" -c "import socket, sys; s = socket.socket(); sys.exit(0 if s.connect_ex(('127.0.0.1', $PORT)) == 0 else 1)" 2>/dev/null && break
		sleep 0.1
	done
	if command -v setsid >/dev/null 2>&1; then
		setsid "$BROWSER" --user-data-dir="$PROFILE" --no-first-run \
			--enable-unsafe-webgpu --enable-features=Vulkan "$URL" >/dev/null 2>&1 </dev/null &
	else
		"$BROWSER" --user-data-dir="$PROFILE" --no-first-run \
			--enable-unsafe-webgpu --enable-features=Vulkan "$URL" >/dev/null 2>&1 </dev/null &
	fi
) &

exec "$PYTHON" serve_local.py --port "$PORT" ${args[@]+"${args[@]}"}
