# No way to get the built iOS simulator `.app` path alone

Reported in [expo/exact#104](https://github.com/expo/exact/issues/104).

Explore (`npx @expo/explore explore:binary <path> --simulator local`) takes an Exact simulator build
as is, but the path appears only in the last line `bun exact.mjs ios` prints:

```
host/apple: <bundle path> on <simulator name> <udid> (<timings>); GPU: …
```

where `<bundle path>` is

```
<app dir>/target/clients/<hash>/<app.id>/ios-simulator/aarch64-apple-ios-sim/embedded/development/standalone/<Name>.app
```

Done when `bun exact.mjs ios --print-path` builds if stale, without installing, and prints only the
`.app` path on stdout, so this works:

```sh
npx @expo/explore explore:binary "$(bun exact.mjs ios --print-path)" --simulator local
```

## Setup

Needs Bun 1.4.2 and an Exact checkout set up with `bun scripts/exact.mjs setup`. Clone this
repository beside the checkout, or set `EXACT2` to the checkout's absolute path:

```sh
git clone https://github.com/expo/exact
git clone REPO_URL exact-repro-ios-app-path
cd exact-repro-ios-app-path
```

## Run

Any app shows it; this one is what `exact new` writes. The script runs against it, or the app
directory you pass:

```sh
./repro.sh
./repro.sh <app dir>
```

Today:

```
BUG: no way to get the built .app's path; today it is only the last line of the build log
```

It exits 1 while `bun exact.mjs ios --help` does not list `--print-path`. Once it does, the script
runs `bun exact.mjs ios --print-path`, which builds for iOS and needs Xcode, and exits 0 when stdout
is exactly the path of an existing `.app`.

Checked against Exact `c582b3b` on macOS 27.2.1, Xcode 27.2, Bun 1.4.2.
