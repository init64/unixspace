<div align=center>
  
  # UNIXSPACE 🛰️
  ![image](https://user-images.githubusercontent.com/62614322/172188765-5dd87f80-0b49-4757-b508-e4b634966af6.png)
  
</div>

### Features 🔫
- Powerfull Terminal User Interface
- Easy to manage & exec any scripts from repository
- Nginx configs samples
- Dockerfiles samples
- Works almost on any unix-based OS

### Architecture 🏗️
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

### ToDo 📃

- [x] Create own repo, with shell scripts
- [x] Built colorful TUI, for easy management
- [ ] Docker execution support
- [ ] Packages group feature support
