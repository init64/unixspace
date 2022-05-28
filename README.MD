# Host Production Resolver

### Architecture
```
.
├── assets                # Assets files for other stuff
│   └── help.dat
├── configs
│   ├── nginx.conf.d
│   │   └── dsx.conf
│   └── pkgs.list
├── docker-compose.yml
├── dsx.pkginstaller.c    # Programm for installing 
├── lib
│   └── dxtlib.c          # DSX Simple C Libary
└── setup.sh              # Script for resolving requirements

4 directories, 7 files
```

### ToDo

- [ ] Create own repo, with shell scripts
- [ ] Built colorful TUI, for easy management
