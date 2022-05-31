// webgtx @ 2022
// dxv1d@tuta.io

#include "lib/dxtlib.c"

int main() {
  char pkgs_list[500];
  char shell[100] = "apt install ";
  rd_file(pkgs_list, "configs/pkgs.list");
  char *pkg = strtok(pkgs_list, "\n");
  while (pkg != NULL) {
	puts(pkg);
	strcat(shell, pkg);
	system(shell);
	pkg = strtok(NULL, "\n");
  }
}
