### Get the Fedora image with built OpenCoarrays

```bash
docker build -t coarray https://github.com/gronki/opencoarrays-fortran-fedora.git
```

### Run the image, mounting the current directory

```bash
docker run -it --rm --workdir /work --volume "$PWD":/work coarray bash
```

### Compile and run a program, inside Docker

```bash
caf program.f90 -o program
mpiexec -n $(nproc) ./program
```
