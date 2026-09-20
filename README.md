Hi.
This is just a small update for the bootloader.

---

## Features
- 16-bit Real Mode initialization.
- Custom Global Descriptor Table (GDT).
- Transition to 32-bit Protected Mode.
- Direct VGA text mode output (`0xB8000`).

## How to Build & Run
Requires `nasm` and `qemu`:
```bash
make
