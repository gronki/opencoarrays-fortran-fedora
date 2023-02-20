FROM fedora

RUN dnf install -y git cmake gcc gfortran mpich-devel && dnf clean all

WORKDIR /tmp/build
RUN curl -L https://github.com/fortran-lang/fpm/releases/download/current/fpm.F90 -o fpm.F90 && \
    gfortran -O -g fpm.F90 -o fpm && install -d /usr/local/bin && install fpm /usr/local/bin && \
    rm -f fpm fpm.F90

RUN git clone --depth 1 https://github.com/sourceryinstitute/OpenCoarrays.git
WORKDIR /tmp/build/build
ENV PATH="$PATH:/usr/lib64/mpich/bin"
RUN cmake ../OpenCoarrays/ -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . && \
    cmake --install . --prefix=/usr/local && \
    rm -rf /tmp/build
WORKDIR /work
