# Packager tools

Tools which can be used by images defined in Package Context. These tools are not used by Packager.

## Build release package

To build a complete release package, use the `go-package.sh` script.

Additional requirements for `go-package.sh`:

- zip
- sed

Example usage:

```bash
./go-package.sh linux x86-64 .
```

## Tools

### Fake uname utility

Fake `uname` utility reads data from a config file and prints them to the user.

The config file is named `uname.txt` and must be located in the `/etc` directory.

To generate config file just run **real** `uname` utility as

```
uname -a > uname.txt
```

Update the `uname.txt` by your needs.

#### Supported flags

- **-m** - machine

#### Unsupported flags

- **-c**
- **-a**
- **-v**
- **-h**
- **-d**

#### Build

Run command in `cmd/uname` directory:

- `CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags '-w'`
