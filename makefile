APP=fslc

all: clean $(APP)  

$(APP): $(APP).o
	gcc -g -o $(APP) $(APP).o `pkg-config --cflags --libs gtk+-3.0` -lcurl -lc -export-dynamic

$(APP).o: $(APP).asm
	nasm -f elf64 $(APP).asm -F dwarf

clean:
	rm -f $(APP).o
