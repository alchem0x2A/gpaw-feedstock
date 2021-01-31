if [[ -d ${CONDA_PREFIX}/share/gpaw ]]
then
    export GPAW_SETUP_PATH=$(ls -rd ${CONDA_PREFIX}/share/gpaw | head -n 1)
else
    echo "Default GPAW_SETUP_PATH not found. You need to define your own!" >&2
fi

