## UI setup

```
export MIX_TARGET="host"
export MIX_ENV="dev"

mix deps.get
mix assets.deploy
```

## Firmware compilatioon

```
export SSID="MyWifi"
export PSK="MySecretForWifi"
export HOSTNAME="anything-but-nerves" # will be anything-but-nerves.local

export MIX_TARGET="rpi0"
export MIX_ENV="dev"

mix deps.get
mix firmware

```
