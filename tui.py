import os.system as sh
from os.path import dirname, realpath


modules_dir = "{}/packaging/".format(dirname(realpath(__file__)))
assets_dir = "{}/assets/".format(dirname(realpath(__file__)))

print("\033c")

with open("{}tui.dat".format(assets_dir), mode="r", encoding="utf-8") as greeting:
    print(greeting.read())
sh("ls {}".format(modules_dir))

print("\n\nWrite the modules with a space.")

user_input = input(":")

if user_input in ("q", "Q"):
    print("\033c")

elif len(user_input) > 0:
    user_modules = user_input.split(" ")
    print(user_modules)

    for module in user_modules:
        module_dir = modules_dir + module
        sh("{}".format(module_dir))
else:
    print("\033c")
