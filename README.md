# NES RAM to FCEUX RAM Tool

##### Version 0.0.0

NES ROM for NROM boards that injects the initial CPU and PPU RAM values of the FCEUX emulator into an NES Console's CPU and PPU RAM.

**_NES RAM to FCEUX RAM Tool was created by Vi Grey (https://vigrey.com) <vi@vigrey.com> and is licensed under the BSD 2-Clause License._**


### Description:
An NES ROM for NROM boards that injects the initial CPU and PPU values of the FCEUX emulator into an NES Console's CPU and PPU RAM to allow for consistent initial RAM values for the start of other games.


### Platforms:
- Linux
- macOS
- BSD


### NES ROM Build Dependencies:
- asm6 _(You'll probably have to build asm6 from source.  Make sure the asm6 binary is named **asm** and that the binary is executable and accessible in your PATH. The source code can be found at **http://3dscapture.com/NES/asm6.zip**)_


### Build NES ROM:
From a terminal, go to the the main directory of this project (the directory this README.md file exists in).  You can then build the NES ROM with the following command.

    $ make

The resulting NES ROM for the NROM board will be located at **bin/nes-ram-to-fceux-INLRetro.nes**.  This ROM will be ready for burning onto the Infinite NES Lives NROM Board.  A version including the 16 byte iNES header is also included at bin/nes-ram-to-fceux.nes if you need it.


### Cleaning NES ROM Build Environment:
If you used `make` to build the NES ROM file, you can run the following command to clean up the build environment.

    $ make clean


### Cartridge Swapping
After the FCEUX initial CPU and PPU RAM values are injected into the NES Console's CPU and PPU RAM (this process will take about 4-5 frames), the game will run an infinite loop that modifies CPU RAM address $0100 to #$4C (JMP) and $0102 to #$01, thus creating a JMP $0100 command at CPU RAM values $0100-$0102 (inclusive range).  With the exception of addresses $0100 and $0102, the CPU and PPU RAM of the NES Console should be set to the initial RAM values of FCEUX.  At this point, while the power is on, you can remove the cartridge from the console and insert the next game you wish to use, then hit reset.  The new game should now start with a consistent CPU and PPU memory state.

**Please Note:** If the NES Console has a functioning CIC Lockout Chip, the console will power off and back on repeatedly until the reset button is pressed.  This will cause the NES Console to break out of the infinite loop.  CPU RAM also degrades over time while the cartridge is being swapped on an NES Console with a functioning CIC Lockout Chip.  It is still possible to cartridge swap on an unmodified front loading NES Console, but be aware of likely RAM decay. If the NES Console has a disabled CIC Lockout Chip (like a modded front loader) or no CIC Lockout Chip at all (like the top loader NES-101 console model), the console should stay powered on running the infinite loop.


### Write NES ROM to INL NROM Using INL-Retro Dumper/Programmer

In the host directory of the INL-retro-progdump repository from *https://gitlab.com/InfiniteNesLives/INL-retro-progdump*, run the following command.  Replace **/path/to/nes-ram-to-fceux-INLRetro.nes** with the path to the **nes-ram-to-fceux-INLRetro.nes** ROM.  The NROM board can be set to either **Vertical** or **Horizontal** Mirroring.

    $ ./inlretro -s scripts/inlretro2.lua -c NES -m nrom -x 32 -y 8 -p /path/to/nes-ram-to-fceux-INLRetro.nes


### Special Thanks

- **DwangoAC** (https://tas.bot): For finally convincing me to make a tool like this after I have procrastinated on making a tool like this for many months

- **Brad Smith** (http://rainwarrior.ca): For providing me with tips and knowledge while streaming production of the TKROM version of the generic NES RAM Debug Tool

- **Paul Molloy** (https://infiniteneslives.com): For creating and providing the NES NROM board for testing and use


### License:
    Copyright (C) 2020, Vi Grey
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

        1. Redistributions of source code must retain the above copyright
           notice, this list of conditions and the following disclaimer.
        2. Redistributions in binary form must reproduce the above copyright
           notice, this list of conditions and the following disclaimer in the
           documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS \`\`AS IS'' AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED. IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
    OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
    SUCH DAMAGE.
