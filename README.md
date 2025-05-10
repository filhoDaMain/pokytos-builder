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
export HOST_POKYTOS_DIR=/home/debian/repos/pokytos-yocto/
```
<br/>

**Install container launcher**
```Bash
$ sudo ./install.sh
```
<br/>

**Launch container with interactive shell**
```Bash
$ pokytos-builder.sh
```
<br/>

![container](./build_and_launch_shell.gif)

Calling **pokytos-builder.sh** from anywhere will launch a container with a shell at $HOST_POKYTOS_DIR

<br/>

**Bitbake one target**
```Bash
$ pokytos-builder.sh bitbake <target and options>
```
<br/>

![bitbake](./bitbake.gif)

Calling **pokytos-builder.sh bitbake target** from anywhere will run inside pokytos-builder container:
* `source $HOST_POKYTOS_DIR/pokytos/pokytos-env`
* `bitbake target`
* exit container

This option, with no interactive shell, can be useful to automate builds.

<br/>

---
<br/>

> [!TIP]
> **Overriding HOST_POKYTOS_DIR from ENV_FILE** is possible <br/>
by exporting HOST_POKYTOS_DIR before calling pokytos-builder.sh <br/>

This can be useful when dealing with multiple repo locations/workspaces

```Bash
$ export HOST_POKYTOS_DIR=/home/debian/repos/pokytos-alt-repo/

# Launch container in pokytos-alt-repo
$ pokytos-console-image bitbake pokytos-console-image

$ unset HOST_POKYTOS_DIR
```