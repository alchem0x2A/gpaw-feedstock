#!/bin/bash
# customize.py example found at: https://gitlab.com/gpaw/gpaw/blob/master/customize.py
cat <<EOF>siteconfig.py
compiler = '${CC}'
mpicompiler = 'mpicc'  # use None if you don't want to build a gpaw-python
mpilinker = 'mpicc'
scalapack = True
fftw = True
libvdwxc = True
libraries += ['scalapack', 'fftw3', 'blas', "vdwxc", ]
              #'scalapack-openmpi',
              #'blacsCinit-openmpi',
              #'blacs-openmpi']
define_macros += [('GPAW_NO_UNDERSCORE_CBLACS', '1')]
define_macros += [('GPAW_NO_UNDERSCORE_CSCALAPACK', '1')]

if 'xc' not in libraries:
    libraries.append('xc')
EOF

# For some reason macOS version clang does not recognize -rpath
if [ "$(uname)" == "Linux" ]; then
    echo "extra_link_args += ['-Wl,-rpath=$PREFIX/lib']" >> siteconfig.py
fi
python -m pip install . --no-deps -vv
# gpaw install-data --no-register $PREFIX/share

mkdir -p "$PREFIX/etc/conda/activate.d"
mkdir -p "$PREFIX/etc/conda/deactivate.d"
cp "$RECIPE_DIR/activate.sh" "$PREFIX/etc/conda/activate.d/gpaw-activate.sh"
cp "$RECIPE_DIR/deactivate.sh" "$PREFIX/etc/conda/deactivate.d/gpaw-deactivate.sh"
