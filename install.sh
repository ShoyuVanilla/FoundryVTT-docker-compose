#!/bin/bash

install_path=${HOME}/FoundryServer

clone_repo() {
    sudo git clone -b release --single-branch https://github.com/ShoyuVanilla/FoundryVTT-docker-compose ${install_path}
}

install_docker() {
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    apt-cache policy docker-ce
    sudo apt install docker-ce -y

    sudo usermod -aG docker ${USER}

    sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
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
