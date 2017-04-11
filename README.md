# cli-pair
Standalone project to compile the bluetoothctl tool on Linux

# Dependencies

## Ubuntu Linux
* GLib
* D-Bus
* D-Bus GLib

The following command should handle the dependencies:
```
sudo apt-get -y install dbus libdbus-1-dev libdbus-glib-1-2 libdbus-glib-1-dev
sudo apt-get install libreadline-dev
```

# Compile
```
make cli-pair
```


