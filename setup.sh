#/bin/sh

fetch_req(  ) {
  apt install -y \
    boxes \
    neovim \
    zsh \
    irssi \
    proxychains \
    git \
    curl \
    htop \
    wget \
    tmux
}

echo "Script working only on deb-family distro"

fetch_req &

if [[ $(whoami) != "root" ]]; then
  echo "RUN SCRIPT FROM ROOT BRUH..." | boxes -d unicornsay 
fi
 
case "$1" in
  "--update")
    echo "Fetching data..." | boxes -d stone
    sleep 2
    cat /etc/*-release | boxes -d stone
    read -p "Update system? (y/N): " option
    if [[ $option == "y" ]]; then
      apt update
      apt full-upgrade
      apt --purge autoremove
      fetch_req
    fi
    ;;
  "--set-env")
    echo "Env Setup Starting..." | boxes -d stone
    # OhMyZSH setup
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
    # Docker installtion
    apt-get remove docker docker-engine docker.io containerd runc
    apt-get install -y \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get install docker-ce docker-ce-cli containerd.io
    # Enabling docker
    systemctl enable docker
    systemctl start docker
    # Nodejs installtion
    wget https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz
    tar -xvf node-v16.13.2-linux-x64.tar.xz
    cd node-v16.13.2-linux-x64.tar.xz 
    cp -r bin/* /bin
    cp -r include/* /usr/include
    cp -r lib/* /lib
    cp -r share/ /usr/share
    # MonogoDB installtion
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
    touch /etc/apt/sources.list.d/mongodb-org-5.0.list
    apt update
    echo "mongodb-org hold" | sudo dpkg --set-selections
    echo "mongodb-org-database hold" | sudo dpkg --set-selections
    echo "mongodb-org-server hold" | sudo dpkg --set-selections
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections``
    ;;
esac
