FROM fedora:latest

RUN dnf install -y git cmake gcc gfortran mpich-devel && dnf clean all

RUN mkdir -p /src/fpm && cd /src/fpm && \
    curl -L https://github.com/fortran-lang/fpm/releases/download/current/fpm.F90 -o fpm.F90 && \
    gfortran -O -g fpm.F90 -o fpm && install -d /usr/local/bin && install fpm /usr/local/bin && \
    rm -f fpm *.mod *.smod

ENV PATH="$PATH:/usr/lib64/mpich/bin"

RUN mkdir -p /src && cd /src && \
    git clone --depth 1 https://github.com/sourceryinstitute/OpenCoarrays.git

RUN mkdir -p /tmp/coarray_build && \
    cmake /src/OpenCoarrays -DCMAKE_BUILD_TYPE=Release -B /tmp/coarray_build && \
    cmake --build /tmp/coarray_build && \
    cmake --install /tmp/coarray_build && \
    rm -rf /tmp/coarray_build

