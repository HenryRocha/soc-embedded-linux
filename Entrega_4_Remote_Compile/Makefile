#
TARGET = hps_gpio
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall   -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/
LDFLAGS =  -g -Wall 
CC = $(CROSS_COMPILE)gcc
ARCH= arm
TARGET_IP = 192.168.15.36

scp: build
	# Faz o build primeiro e em seguida usa SCP para copiar o arquivo gerado para
	# a FPGA.
	scp $(TARGET) root@$(TARGET_IP):/home/root

run: scp
	# Faz o SCP e em seguida se conecta a FPGA e executa o programa.
	ssh -tt root@$(TARGET_IP) /home/root/$(TARGET)

gdb: scp
	# Faz o SCP e em seguida se conecta na FPGA por SSH e executa o gdb server em background
	# e termina a conexão SSH.
	ssh -tt root@$(TARGET_IP) gdbserver localhost:6969 /home/root/$(TARGET) 1>/dev/null & exit
	# Conecta o gdb no server da FPGA.
	(echo "target remote $(TARGET_IP):6969"; cat) | gdb-multiarch ./$(TARGET)

build: $(TARGET)

$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@ 

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~