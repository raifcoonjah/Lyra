import os
import prettytable as pt
 

sentence = "Welcome to \n Tabel >_ Installer!"
width = 35


t = pt.PrettyTable()

t.field_names = ['v2.1.2021']
[t.add_row([sentence[i:i + width]]) for i in range(0, len(sentence), width)]

print(t)
print("")

inp = ""
while inp != "1" and inp != "2":
    inp = input("[+] Please choose between Debian/ubuntu version (1) or Arch version (2): \n[+] Enter Number: ")
    if inp != "1" and inp != "2":
        print("You must between Debian/Ubuntu base (1) or Arch base (2)")

inp2 = ""
while inp2 != "1" and inp2 != "2":
    inp2 = input("[+] Please choose what browser to install: Firefox  (Recommended) or Brave Browser (2) \n[+] Enter Number: ")
    if inp2 != "1" and inp2 != "2":
        print("You must between Firefox (Recommended) (1) or Brave Browser (2)")


if inp == "1":
    print(":: Starting Debian/Ubuntu base installer.. ")

if inp2 == "1":
    print("Installing Firefox Browser :)")
    os.system("sudo apt-get install firefox")

if inp2 == "2":
    print("--> Installing brave using recommended method: https://brave.com/linux/")
    print(" Installing recommended apt-transport-https curl")
    os.system("sudo apt install apt-transport-https curl")
    print("Downloads Brave keyring.pgp")
    os.system(" sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg")
    print(" Adding brave apt repository")
    os.system(""" echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list""")
    os.system(" sudo apt update")
    print(":: Downloading & installing brave browser!")
    os.system(" sudo apt install brave-browser")


if inp == "2":
    print("Starting Arch base installer..")

    