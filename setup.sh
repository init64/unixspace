#/bin/bash

nodejs_url="https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz"
nodejs_dirname="node-v16.13.2-linux-x64"

fetch_req(  ) {
  apt update -y
  apt install -y \
    htop \
    wget \
    neovim \
    zsh \
    irssi \
    tmux \
    boxes \
    proxychains \
    git \
    curl \
    xz-utils \
    nginx \
    certbot \
    python3-certbot-nginx \
    letsencrypt
}

setup_nginx(  ) {
  cp -r ./configs/nginx.conf.d/* /etc/nginx/conf.d
  systemctl restart nginx
  systemctl status nginx
  echo "Nginx is ready" | boxes -d unicornsay
}

setup_glances(  ) {
  wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
  echo "deb https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
  apt update
  apt install grafana-enterprise
}

setup_prometheus(  ) {
  wget https://github.com/prometheus/prometheus/releases/download/v2.35.0/prometheus-2.35.0.linux-amd64.tar.gz
  tar -xvf prometheus*
}

setup_nodejs(  ) {
  wget $nodejs_url 
  tar -xvf $nodejs_dirname.tar.xz
  cp -r $nodejs_dirname/bin/* /bin
  cp -r $nodejs_dirname/include/* /usr/include
  cp -r $nodejs_dirname/lib/* /lib
  cp -r $nodejs_dirname/share/ /usr/share
}

# This version only for debian <= 9
setup_old_mongo(  ) {
  apt install software-properties-common dirmngr
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
  add-apt-repository 'deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main'
  apt update  
  apt install mongodb-org
  systemctl start mongod
}

setup_mongo( ) {
  wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
  echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee
  apt-get install mongodb-org mongodb-org-server mongodb-org-database mongodb-org-mongos mongodb-org-shell mongodb-org-tools -y
  systemctl start mongod && systemctl enable mongod
  systemctl status mongod
}

setup_docker( ) {
  apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt update
  apt remove docker docker-engine docker.io containerd runc
  apt install docker-ce docker-ce-cli containerd.io
}

echo "Script working only on deb-family distro"
 
case "$1" in
  *)
    echo DSX SETUP SCRIPT | boxes -d stone
    cat assets/help.dat
    break;;
  "--upd-cfg")
    setup_nginx
    break;;
  "--dsx-env")
    ./setup.sh --base-env 
    setup_nginx
    setup_prometheus
    setup_glances
    break;;
  "--base-env")
    echo "Env Setup Starting..." | boxes -d stone
    # Requirements
    fetch_req
    if [[ $(whoami) != "root" ]]; then
      echo "RUN SCRIPT FROM ROOT BRUH..." | boxes -d unicornsay 
    fi
    # Nodejs installtion
    setup_nodejs
    # Docker installtion
    setup_docker
    # MonogoDB installtion
    setup_mongo
    # Certbot + letsencrypt
    certbot    
    # OhMyZSH setup
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ;;
esac
