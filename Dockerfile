FROM fedora

RUN dnf install -y git cmake gcc gfortran mpich-devel && dnf clean all

WORKDIR /src/coarray
RUN git clone --depth 1 https://github.com/sourceryinstitute/OpenCoarrays.git
WORKDIR /src/coarray/build
ENV PATH="$PATH:/usr/lib64/mpich/bin"
RUN cmake ../OpenCoarrays/ -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . && \
    cmake --install . --prefix=/usr/local && \
    rm -rf /src/coarray
WORKDIR /work
