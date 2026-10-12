# playgta5 Source Code
This code is grabbed from playgta5.com before it got took down. You can run this locally or make it public hehe.

# Credits
Shoutout to Sebas Furbastian on Telegram for scrapping this code. Idk what is his GitHub but here's the Telegram and X.

Telegram: @SebasKitten

X: @Sebas_Kitten

# Link
Telegram: https://t.me/reGRANDTA

Discord: https://discord.gg/hrbcPjjZfj


# Disclaimer
I don't host the `.\mirror` folder since it has copyrighted content from Rockstar Games. Please find the files by yourself.

No copyrighted file is included in this repo. If Rockstar Games or any affiliated group think this repo has copyright infringement things, email me at shadany7824@gmail.com for me to took it down.

And don't email me for asking the mirror folder. I will not reply to the email.

# How to use
1. Download the ZIP or just `git clone` it. It should have all this file and folders.
<p align="center">
  <img src="media/Screenshot 2026-10-07 172103.png" alt="playgta5 SC">
</p>

2. Paste your `.mirror` folder at your desired path. (It should have 19.7 GB of file size. Check the pic below.)
<p align="center">
  <img src="media/Screenshot 2026-10-07 172216.png" alt="Folder Properties">
</p>
<p align="center">
  <img src="media/Screenshot 2026-10-07 172718.png" alt="Folder Properties">
</p>
<p align="center">
  <img src="media/Screenshot 2026-10-07 172758.png" alt="Folder Properties">
</p>

3. Run the `Launch-Local.cmd` and it will automatically open the URL at `http://localhost:8000/`.

4. Voila!

# Linux / macOS
The bundled `runtime\` folder is a Windows-only Python, so the Linux launcher uses your system Python instead:

1. Place the mirror folder at `mirror/playgta5.com/` (same as Windows).
2. You need Python 3.11+ (`sudo apt install python3` on most distros).
3. Run it:

```bash
./Launch-Local.sh
```

It opens `http://localhost:8000/` like the Windows launcher. Any args are passed to the server, e.g. `./Launch-Local.sh --port 9000`.

Browser: the engine needs WebGPU. Recent Chromium/Chrome works out of the box on Linux with Vulkan drivers. If the GPU worker fails to start, try launching the browser with `--enable-unsafe-webgpu --enable-features=Vulkan`. Firefox support is still catchier on Linux.

To download the game data on Linux (same script, standard library only):

```bash
python3 mirror_site.py --workers 32 --rate-mib 0
```

# Requirement
Scripts require standard-library Python 3.11 or newer. The bundled Python path
in the commands above is specific to the original PC; the portable ZIP instead
provides `runtime\python.exe` and the double-click launcher.
Completed files and `.part` transfers are retained for resumption. Final checks
cover inventory sizes, runtime hash samples, WASM signature, HTTP isolation,
range reads and both batch formats. Actual gameplay requires separate browser
validation. A public client snapshot is not the site's original development repository.

To resume with the current uncapped settings, append `--workers 32 --rate-mib 0`
to the downloader command. Content lengths from HTTP take precedence over the
source manifest when it is stale; mismatches are recorded explicitly.
