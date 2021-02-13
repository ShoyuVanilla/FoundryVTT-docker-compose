#!/bin/bash

install_path=${HOME}/FoundryServer

clone_repo() {
    sudo git clone -b release --single-branch --depth=1 https://github.com/ShoyuVanilla/FoundryVTT-docker-compose ${install_path}
}

install_docker() {
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
}

open_ports() {
    sudo iptables -I INPUT 5 -i ens3 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
    sudo iptables -I INPUT 5 -i ens3 -p tcp --dport 8080 -m state --state NEW,ESTABLISHED -j ACCEPT
    sudo iptables -I INPUT 5 -i ens3 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
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
    open_ports
    make_alias
}

main
