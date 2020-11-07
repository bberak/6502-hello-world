 const kb = 32 * 1024;
const rom = Buffer.alloc(kb);
const fs = require("fs");
const path = require("path");
const [outfile] = process.argv.reverse();
const outfolder = fs.mkdirSync(path.dirname(outfile), { recursive: true });
const ws = fs.createWriteStream(outfile);

// Fill rom with no-op instructions
rom.fill(0xea)

// The processor sees the two addresses below as fffc and fffd. A high signal on A15 will enable
// the rom chip - which will respond with address 8000 as the start of the program (PC). Address 8000
// to the processor will tranlate to 0000 (the first address) on the rom chip.
rom[0x7ffc] = 0x00;
rom[0x7ffd] = 0x80;

// Program start
const code = Buffer.from([
	0xa9, 0xff,			// Load ff into acc
	0x8d, 0x02, 0x60,	// Store contents of acc into address 6002 (data direction register b of via chip)

	0xa9, 0x55,			// Load 55 into the acc
	0x8d, 0x00, 0x60,	// Store contents of acc into address 6000 (port b of via chip)

	0xa9, 0xaa,			// Load aa into the acc
	0x8d, 0x00, 0x60,	// Store contents of acc into address 6000 (port b of via chip)

	0x4c, 0x05, 0x80	// Jump back to instruction on line 20
])

// Copy code into the start of the rom
code.copy(rom, 0);

ws.write(rom);
ws.end();