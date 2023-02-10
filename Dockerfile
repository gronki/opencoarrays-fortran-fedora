FROM fedora:latest

RUN dnf install -y git cmake gcc gfortran mpich-devel && dnf clean all
ENV PATH="$PATH:/usr/lib64/mpich/bin"

WORKDIR /src/coarray
RUN git clone --depth 1 https://github.com/sourceryinstitute/OpenCoarrays.git

WORKDIR /src/coarray/build
RUN cmake ../OpenCoarrays/ -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . && \
    cmake --install . --prefix=/usr/local && \
    cd && rm -rf /src/coarray

WORKDIR /work
