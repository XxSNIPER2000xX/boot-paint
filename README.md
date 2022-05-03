# boot-paint
primitive paint program that runs in the boot sector

<h2>Introduction</h2>

My first attempt at making a boot sector game

<h2>Build Instructions</h2>

```
git clone https://github.com/XxSNIPER2000xX/boot-paint
cd boot-paint
nasm -f bin bootPaint.s -o bootPaint
qemu-system-i386 -hda bootPaint
```

<h2>Controls</h2>

* arrow keys  -> MOVE
* q           -> RED
* w           -> GREEN
* e           -> BLUE
* a           -> BLACK (eraser)
* esc         -> QUIT TO OS

<h2>Inspired By</h2>

Tetros: https://github.com/daniel-e/tetros

Lightsout: https://github.com/XlogicX/lightsout
