#!/bin/bash

install_path=${HOME}/FoundryServer

clone_repo() {
    sudo git clone -b release --single-branch https://github.com/ShoyuVanilla/FoundryVTT-docker-compose ${install_path}
}

install_docker() {
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh

    sudo curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    sudo apt-get autoremove
}

make_alias() {
    if grep -q "# Foundry aliases" "${HOME}/.bashrc"; then
        return
    fi

    sudo echo '' >> $HOME/.bashrc
    sudo echo "# Foundry aliases" >> $HOME/.bashrc
    sudo echo "if [ -f ${install_path}/.bash_aliases ]; then" >> $HOME/.bashrc
    sudo echo "    source ${install_path}/.bash_aliases" >> $HOME/.bashrc
    sudo echo "fi" >> $HOME/.bashrc
    bash
}

main() {
    clone_repo
    install_docker
    make_alias
}

main
