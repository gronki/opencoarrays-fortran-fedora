FROM fedora

RUN dnf install -y git cmake gcc gfortran mpich-devel && dnf clean all

WORKDIR /tmp/build
RUN git clone --depth 1 https://github.com/sourceryinstitute/OpenCoarrays.git
WORKDIR /tmp/build/build
ENV PATH="$PATH:/usr/lib64/mpich/bin"
RUN cmake ../OpenCoarrays/ -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . && \
    cmake --install . --prefix=/usr/local && \
    rm -rf /tmp/build
WORKDIR /work
