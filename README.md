Hi everyone,
I am a 13-year-old who felt extremely bored, so I decided to learn programming. This is just a simple project, and I would love to hear your feedback—whether positive or negative!

---

## About The Project
An experimental, custom x86 operating system bootloader built completely from scratch in Assembly.

## Features
- 16-bit Real Mode initialization.
- Custom Global Descriptor Table (GDT).
- Transition to 32-bit Protected Mode.
- Direct VGA text mode output (`0xB8000`).

## How to Build & Run
Requires `nasm` and `qemu`:
```bash
make
