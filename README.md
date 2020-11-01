# 6502-hello-world

A repo for holding my 6502 hello world code

## Prerequisites

- Node
- NPM
- [Homebrew](https://brew.sh/) (if using Mac)
- [Chocolatey](https://chocolatey.org/) (if using Windows)

> **HEADS UP WINDOWS USERS:** I'm using [Hyper terminal](https://hyper.is/), so if you are using a different commandline prompt - I cannot guarantee that all of the `npm scripts` will work (although they might)

## Getting Started

Firstly, clone the repo and configure it for git tracking:

```
git clone https://github.com/bberak/65xx-kit.git [new-project]

cd [new-project]

rm -rf .git # Windows: rmdir /S .git

git init

git add .

git commit -m "First commit"

git remote add origin https://github.com/[you]/[new-project].git

git push -u origin master
```

Get tools:

```
npm install
npm run setup
```

## Developing

Build assembler files with:

```
npm run build src/file.asm
```
> By default used 6510 instruction set. Modify the `build` scripts in the `package.json` to change this.

By convention, .asm files should indicate their output paths using a macro at the top of the file:

```
!to "build/file.prg"
```

After building is complete, you can run your program on the c64 emulator using:

```
npm run start build/file.prg
```

## Automatically starting programs

In order for the emulator to automatically begin executing your machine code, include the following lines at the start of your program:

```
*=$0801
!byte $0E, $08, $0A, $00, $9E, $20, $28, $32
!byte $30, $36, $34, $29, $00, $00, $00
*=$0810  
```

> This will insert a loader at the beginning of your program that will begin executing machine code from location $0810

## C64 / 6510 Syntax Highlighting

For syntax highlighting of the .asm files - use the [Kick Assembler Sumlime package](https://packagecontrol.io/packages/Kick%20Assembler%20(C64))

## Resources

- [ACME opcodes](http://www.cbmhardware.de/show.php?r=14&id=7)
- [C64 memory](https://dustlayer.com/c64-architecture/2013/4/13/ram-under-rom)
- [Dustlayer tutorials](https://dustlayer.com/c64-coding-tutorials/2013/2/17/a-simple-c64-intro)
- [Easy 6502 tutorials](https://skilldrick.github.io/easy6502/)
- [Codebase64 tutorials](https://codebase64.org/doku.php?id=base:machine_language_tutorial)
- [Ben Eater's 6502 YouTube series](https://www.youtube.com/watch?v=LnzuMJLZRdU&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH)



