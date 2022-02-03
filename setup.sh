#/bin/sh

fetch_req(  ) {
  apt install -y \
    boxes \
    neovim \
    zsh \
    irssi \
    proxychains \
    git \
    curl 
}

echo "Script working only on deb-family distro"

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
      fetch_req
    fi
    ;;
esac
