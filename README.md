### Get the Fedora with OpenMPI and OpenCoarrays

```bash
docker build -t fedora_coarray https://github.com/gronki/opencoarrays-fortran-fedora.git
```

### Run the image, mounting the current directory

```bash
docker run -it -v "$PWD":/work fedora_coarray bash
```

### Compile and run a program

```bash
caf program.f90 -o program
mpiexec ./program
```
