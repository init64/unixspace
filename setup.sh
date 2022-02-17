#/bin/sh

nodejs_url="https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz"
nodejs_dirname="node-v16.13.2-linux-x64"

fetch_req(  ) {
  apt update -y
  apt install -y \
    # Tools
    htop \
    wget \
    neovim \
    zsh \
    irssi \
    tmux \
    # Base utils
    boxes \
    proxychains \
    git \
    curl \
    xz-utils \
    # Web
    nginx \
    certbot \
    python3-cerbot-nginx \
    letsencrypt
}

setup_nodejs(  ) {
  wget $nodejs_url 
  tar -xvf $nodejs_dirname.tar.xz
  cp -r $nodejs_dirname/bin/* /bin
  cp -r $nodejs_dirname/include/* /usr/include
  cp -r $nodejs_dirname/lib/* /lib
  cp -r $nodejs_dirname/share/ /usr/share
}

setup_mongo(  ) {
  apt install software-properties-common dirmngr
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
  add-apt-repository 'deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main'
  apt update  
  apt install mongodb-org
  systemctl start mongod
}

echo "Script working only on deb-family distro"

fetch_req &

if [[ $(whoami) != "root" ]]; then
  echo "RUN SCRIPT FROM ROOT BRUH..." | boxes -d unicornsay 
fi
 
case "$1" in
  "--set-env")
    echo "Env Setup Starting..." | boxes -d stone
    # Nodejs installtion
    setup_nodejs
    # MonogoDB installtion
    setup_mongo
    # Certbot + letsencrypt
    certbot    
    # OhMyZSH setup
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ;;
esac
