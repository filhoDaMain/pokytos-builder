# pokytos-builder
Docker image for Yocto builds

## Quick reference

**Build image**
```Bash
$ ./build.sh
```
<br/>

**Set path to pokytos repo base dir**
```Bash
# Edit in ENV_FILE file
export HOST_POKYTOS_DIR=/home/debian/dev/repos/pokytos-yocto/
```
<br/>

**Install container launcher**
```Bash
$ sudo ./install.sh
```
<br/>

**Launch container**
```Bash
$ pokytos-builder.sh
```
<br/>

![container](./pokytos-builder.gif)

<br/>

Calling **pokytos-builder.sh** from anywhere will fire a container at $HOST_POKYTOS_DIR
