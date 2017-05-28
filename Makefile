CC=gcc
CCOPTS=-Wall -Wextra -DHAVE_CONFIG_H
.PHONY: all clean

client_bluetoothctl_SOURCES_DIST = client/main.c \
	client/display.c client/agent.c \
	client/gatt.c monitor/uuid.c

DEP_OBJECT = gdbus/mainloop.o gdbus/client.o gdbus/object.o gdbus/polkit.o gdbus/watch.o

INC = -I/usr/include -I./ $(shell pkg-config --cflags dbus-glib-1) \
                     $(shell pkg-config --cflags dbus-1)\
		     $(shell pkg-config --cflags boost)\
		     $(shell pkg-config --cflags glib-2.0)

# Object cli-pair depends on
LIBS = $(shell pkg-config --libs dbus-glib-1) \
       $(shell pkg-config --libs dbus-1) \
       $(shell pkg-config --libs glib-2.0)\
       $(shell pkg-config --libs boost)\
       -L/usr/local/lib -lreadline

all: $(TARGETS)

## Object files
gdbus/mainloop.o:
	gcc -O $(INC) -c ./gdbus/mainloop.c
	mv mainloop.o gdbus/mainloop.o

gdbus/client.o:
	gcc -O $(INC) -c ./gdbus/client.c
	mv client.o gdbus/client.o

gdbus/object.o:
	gcc -O $(INC) -c ./gdbus/object.c
	mv object.o gdbus/object.o

gdbus/polkit.o:
	gcc -O $(INC) -c ./gdbus/polkit.c
	mv polkit.o gdbus/polkit.o

gdbus/watch.o:
	gcc -O $(INC) -c ./gdbus/watch.c
	mv watch.o gdbus/watch.o

cli-pair: clean create_dir gdbus/mainloop.o gdbus/client.o gdbus/object.o gdbus/polkit.o gdbus/watch.o
	$(CC) $(CCOPTS) $(INC) -o cli-pair $(client_bluetoothctl_SOURCES_DIST) $(DEP_OBJECT) $(LIBS)
	mv cli-pair bin/cli-pair

create_dir:
	mkdir bin

clean_dir:
	rm -rf ./bin
clean: clean_dir
	rm -f $(TARGETS) $(DEP_OBJECT)

%: %.c
	$(CC) $(CCOPTS) -o $@ $< -lbluetooth $(LIBS)
