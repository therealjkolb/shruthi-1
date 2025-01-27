# Copyright 2009 Emilie Gillet.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
include shruthi/makefile
#include bootloader/makefile
FIRMWARE      = $(BUILD_DIR)shruthi1.hex
BOOTLOADER    = $(BUILD_DIR)muboot.hex
EEPROM        = shruthi/data/factory_data/internal_eeprom.hex
EEPROM_XT     = shruthi/data/factory_data/internal_eeprom_xt.hex

upload_all:	$(FIRMWARE) $(BOOTLOADER)
		$(AVRDUDE) $(AVRDUDE_COM_OPTS) $(AVRDUDE_ISP_OPTS) \
			-U flash:w:$(FIRMWARE):i -U flash:w:$(BOOTLOADER):i -U eeprom:w:$(EEPROM):i

bake_all_xt:	$(FIRMWARE) $(BOOTLOADER)
		make -f bootloader/makefile fuses
		$(AVRDUDE) -B 1 $(AVRDUDE_COM_OPTS) $(AVRDUDE_ISP_OPTS) \
			-U eeprom:w:$(EEPROM_XT):i \
			-U flash:w:$(FIRMWARE):i -U flash:w:$(BOOTLOADER):i \
			-U lock:w:0x2f:m

bake_all:	$(FIRMWARE) $(BOOTLOADER)
		make -f bootloader/makefile fuses
		$(AVRDUDE) -B 1 $(AVRDUDE_COM_OPTS) $(AVRDUDE_ISP_OPTS) \
			-U eeprom:w:$(EEPROM):i \
			-U flash:w:$(FIRMWARE):i -U flash:w:$(BOOTLOADER):i \
			-U lock:w:0x2f:m

backup:	$(EEPROM)
		$(AVRDUDE) $(AVRDUDE_COM_OPTS) $(AVRDUDE_ISP_OPTS) -U eeprom:r:$(EEPROM):i

