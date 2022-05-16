#include "lib/dxtlib.c"

void parse_file(char *filename, char *dat[]) {
  int c;
  int idx = 0;
  FILE *file;
  file = fopen(filename, "r");
  if (file) {
    while ((c = getc(file)) != EOF) {
      idx++;
    }
  }
}

int main() {
  int data[50][200];
  parse_file("assets/help.dat", data)
}
