# pokytos-builder
Docker image for Yocto builds

Contains:
- Image Dockerfile
- Launcher script

## Quick reference

### Build Docker image
```Bash
$ ./build.sh
```

### Install launcher script
Modify [MOUNT](https://github.com/filhoDaMain/pokytos-builder/blob/main/MOUNT) with all paths to mount from host inside Docker container
```Text
# First path becomes workdir inside container
${HOME}/repos/pokytos-yocto/pokytos/
${HOME}/repos/pokytos-yocto/.repo/
[...]
```

Modify [RUN_OPTS](https://github.com/filhoDaMain/pokytos-builder/blob/main/RUN_OPTS) with options passed to `docker run`
```Text
# Options passed to docker run
--user $(id -u):$(id -g)
--network host
[...]
```

Install `pokytos-builder.sh`, `MOUNT` and `RUN_OPTS`
```Bash
$ sudo ./install.sh
```
```Text
NOTE:
pokytos-builder.sh is installed in /usr/local/bin/
MOUNT and RUN_OPTS are installed in /usr/local/etc/
```

### Invoke Docker container

![pokytos-builder](./pokytos-builder.gif)

#### 1) Interactive shell
```Bash
$ pokytos-builder.sh
```
- A **pokytos-builder** container is **launched with an interactive shell** using docker options read from installed `RUN_OPTS` file;
- All directories and files from installed `MOUNT` file are mounted in container;
- First path from `MOUNT` becomes the container **workdir**.

</br>

#### 2) Bitbake target and exit
```Bash
$ pokytos-builder.sh bitbake <target and arguments>
```
- Same as in **Interactive shell**, plus:
- Inside **workdir** the following is executed
```Bash
$ source pokytos-env
$ bitbake <target and arguments>
```
- Container exits with return value from bitbake status

</br>

#### 3) Mount directories from another file
```Bash
$ pokytos-builder.sh -m <mount>
```
Sometimes you may have more than one instance of a Yocto image repository to build.

In that case, you can create another **text file** like **MOUNT** and install it somewhere else. Define in that file the directories pertaining to this other repo and invoke **pokytos-builder.sh** with `-m` option followed by the path to the alternative MOUNT file.

E.g.: Use `/home/foo/my-unstable-repo-dirs.conf` instead of installed `MOUNT`file:
```Text
${HOME}/repos/unstable-pokytos-yocto/pokytos/
${HOME}/repos/unstable-pokytos-yocto/.repo/
[...]
```
This option can be combined with `bitbake` argument too
```Bash
$ pokytos-builder.sh \
-m /home/foo/my-unstable-repo-dirs.conf \
bitbake pokytos-console-image -c do_rootfs
```
