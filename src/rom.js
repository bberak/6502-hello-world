const fs = require("fs");
const kb = 32 * 1024;
const buf = Buffer.alloc(kb);
const ws = fs.createWriteStream("./build/rom.bin")

buf.fill(0xEA)
ws.write(buf);
ws.end();