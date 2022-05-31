# Host Production Resolver

### Architecture
```fish
.
├── assets                # Assets files for other stuff
│   └── help.dat
├── configs
│   ├── nginx.conf.d
│   │   ├── dsx.conf
│   │   └── genkan.conf
│   └── pkgs.list
├── docker-compose.yml
├── dsx.pkginstaller.c    # Programm for installing 
├── lib
│   └── dxtlib.c          # DSX Simple C Libary
├── packaging
│   ├── fetch_req
│   ├── setup_docker
│   ├── setup_glances
│   ├── setup_mongo
│   ├── setup_nginx
│   ├── setup_nodejs
│   ├── setup_old_mongo
│   └── setup_prometheus
├── README.MD
└── setup.sh              # Script for resolving requirements

5 directories, 17 files
```

### ToDo

- [ ] Create own repo, with shell scripts
- [ ] Built colorful TUI, for easy management
