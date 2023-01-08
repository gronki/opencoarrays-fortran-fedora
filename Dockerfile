FROM fedora

RUN dnf install -y git cmake gcc gfortran openmpi-devel && dnf clean all

WORKDIR /tmp/build
RUN git clone --depth 1 https://github.com/sourceryinstitute/OpenCoarrays.git
WORKDIR /tmp/build/build
ENV PATH="$PATH:/usr/lib64/openmpi/bin"
RUN cmake ../OpenCoarrays/ -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . && \
    cmake --install . --prefix=/usr/local && \
    rm -rf /tmp/build
ENV OMPI_ALLOW_RUN_AS_ROOT=1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1
ENV OMPI_MCA_btl_vader_single_copy_mechanism=none
WORKDIR /work
