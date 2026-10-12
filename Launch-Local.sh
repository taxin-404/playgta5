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

exec "$PYTHON" serve_local.py --open "$@"
