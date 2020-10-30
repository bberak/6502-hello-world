const fs = require("fs");
const kb = 32 * 1024;
const rom = Buffer.alloc(kb);
const ws = fs.createWriteStream("./build/rom.bin")

rom.fill(0xea)

// Program start

rom[0] = 0xa9; // Load 0x42 into the acc
rom[1] = 0x42;

rom[2] = 0x8d; // Store the contents of acc into address 6000
rom[3] = 0x00;
rom[4] = 0x60;

// The processor sees these addresses as fffd and fffd. A high signal on A15 will enable
// the rom chip. Which will respond with address 8000 as the start of the program (PC). 8000
// to processor will tranlate to 0000 (the first address) on the rom chip.
rom[0x7ffc] = 0x00;
rom[0x7ffd] = 0x80;

ws.write(rom);
ws.end();