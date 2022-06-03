#/bin/env sh

source packaging/*

nodejs_url="https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz"
nodejs_dirname="node-v16.13.2-linux-x64"

echo "Script working only on deb-family distro"

case "$1" in
	*)
		echo DSX SETUP SCRIPT | boxes -d stone
		cat assets/help.dat
		break;;

  "--help")
    cat assets/help
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

		# Nodejs installation
		setup_nodejs

		# Docker installation
		setup_docker

		# MonogoDB installation
		setup_mongo

		# Certbot + letsencrypt
		certbot

		# OhMyZSH setup
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	  break;;
esac
