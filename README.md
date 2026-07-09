# pokytos-builder
Docker image for Yocto builds

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
Install launcher script and `MOUNT` file
```Bash
$ sudo ./install.sh
```

### Invoke Docker container

![pokytos-builder](./pokytos-builder.gif)

#### 1) Interactive shell
```Bash
$ pokytos-builder.sh
```
- A **pokytos-builder** container is launched with an interactive shell;
- All directories and files from installed `MOUNT` are mounted in container;
- First path from `MOUNT` becomes the container **workdir**.

</br>

#### 2) Bitbake target and exit
```Bash
$ pokytos-builder.sh bitbake <target and arguments>
```
- A **pokytos-builder** container is launched;
- All directories and files from installed `MOUNT` are mounted in container;
- Inside **workdir** (first path from `MOUNT`) the following happens
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

In that case, you can create another **text file** like **MOUNT** and install it somewhere else. Define in that file the directories pertaining to this other repo and invoke **pokytos-builder.sh** with `-m` option followed by the path to that conf file.

E.g.: `/home/foo/my-unstable-repo-dirs.conf`:
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
