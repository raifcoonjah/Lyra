import os
import prettytable as pt
 

sentence = "Welcome to \n D4adarrInstaller!"
width = 35


t = pt.PrettyTable()

t.field_names = ['v2.0.2021']
[t.add_row([sentence[i:i + width]]) for i in range(0, len(sentence), width)]

print(t)

inp = ""
while inp != "1" and inp != "2":
    inp = input("[+] Please choose between Debian/ubuntu base (1) or Arch base (2): \n")
    if inp != "1" and inp != "2":
        print("You must between Debian/Ubuntu base (1) or Arch base (2)")

if inp == "1":
    print(" Starting Debian/Ubuntu base installer.. ")
    print("Ok.. Running debian-ubuntu script now!")
    os.chmod("./script/debian.sh", 0o664)
    os.system('sh ./script/debian.sh')
if inp == "2":
    print("Starting Arch base installer..")