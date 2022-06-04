# Host Production Resolver

### Architecture
```sh
.
├── assets
│   ├── help.dat
│   └── tui.dat
├── cli.sh
├── configs
│   ├── nginx.conf.d
│   │   ├── dsx.conf
│   │   └── genkan.conf
│   └── pkgs.list
├── docker-compose.yml
├── dsx.pkginstaller.c
├── lib
│   └── dxtlib.c
├── main.lua
├── packaging
│   ├── fetch_req
│   ├── setup_docker
│   ├── setup_glances
│   ├── setup_mongo
│   ├── setup_nginx
│   ├── setup_nodejs
│   ├── setup_old_mongo
│   └── setup_prometheus
└── README.md

5 directories, 19 files
```

### ToDo

- [x] Create own repo, with shell scripts
- [x] Built colorful TUI, for easy management
