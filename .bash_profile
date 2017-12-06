# Docker
: <<'#__CO__'
pushd '/c/Program Files/Docker Toolbox'
DOCKER_MACHINE=./docker-machine.exe
VM=default
if [ "$($DOCKER_MACHINE status $VM)" != "Running" ]; then
    echo "Starting machine $VM..."
    $DOCKER_MACHINE start $VM
    yes | $DOCKER_MACHINE regenerate-certs $VM
fi
echo "Setting environment variables for machine $VM..."
eval "$($DOCKER_MACHINE env --shell=bash $VM)"
popd
#__CO__

source ~/.bashrc
