# 6502 Hello World

A repo for holding my 6502 hello world code

## Prerequisites

- Node
- NPM
- [Homebrew](https://brew.sh/) (if using Mac)
- [Chocolatey](https://chocolatey.org/) (if using Windows)

> **HEADS UP WINDOWS USERS:** I'm using [Hyper terminal](https://hyper.is/), so if you are using a different commandline prompt - I cannot guarantee that all of the `npm scripts` will work (although they might)

## Getting Started

Firstly, clone the repo:

```
git clone https://github.com/bberak/6502-hello-world.git
cd 6502-hello-world
```

Install prerequisites:

```
npm install
npm run setup
```

## Assembling

Build assembler files with:

```
npm run acme src/file.asm
```

> Defaults to using `6502` instruction set. Modify the `acme` scripts in the `package.json` to change this.

By convention, .asm files should indicate their output paths using a macro at the top of the file:

```
!to "build/file.prg"
```

## Emulating (for Commodore 64 only)

After assembling is complete, you can run your program on the vice emulator using:

```
npm run vice build/file.prg
```

> You will most likely need to change the assembler instruction set to `6510` see above.

## Writing to EEPROMs 

To write your program to a rom, run:

```
npm run minipro build/file.prg
```

> Works with the MiniPRO TL866xx series of chip programmers

> By default, is setup to write to the `AT28C256` rom chip. Modify the `minipro` scripts in the `package.json` to change this.

## 65xx Assembly Syntax Highlighting

For syntax highlighting of the .asm files - use the [Kick Assembler Sumlime package](https://packagecontrol.io/packages/Kick%20Assembler%20(C64))

## Resources

- [ACME opcodes](http://www.cbmhardware.de/show.php?r=14&id=7)
- [C64 memory](https://dustlayer.com/c64-architecture/2013/4/13/ram-under-rom)
- [Dustlayer tutorials](https://dustlayer.com/c64-coding-tutorials/2013/2/17/a-simple-c64-intro)
- [Easy 6502 tutorials](https://skilldrick.github.io/easy6502/)
- [Codebase64 tutorials](https://codebase64.org/doku.php?id=base:machine_language_tutorial)
- [Ben Eater's 6502 YouTube series](https://www.youtube.com/watch?v=LnzuMJLZRdU&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH)



