# Design flow

## System Level specfication and Spec
- You must read the spec carefully. High lighting every details first.

## Algorithm
- First understand the algorithm then recreate it using basic operations,data structures and algorithms without using libraries.
The data structure you used must be hardware friendly. At the same time, you have to generate the testbench i.e. your golden model for your hardware.

## ASMD(Control)
- Convert the algorithm you just derived to ASMD chart to have a clear view about which components are needed.
- Also it specifies the states and datapath components needed for further simplification
- At the same time, perform FSM factorization to further simplify the logic of controller.
- Which block can have its own local CTR.

## Datapath(Microarchitecture)
- Create the datapath from the ASMD chart you just derived. Visualize the main components needed.(RF)(ALU)(MEM) etc...

- DEMUX and MUX ,RF, ALU, MEM, PIPE, FIFO, BUF, STACK, Caches ,BUS, SCOREBOARD ,ScratchBoard,EPOCH, MAIN CTR, I/O interfaces, Global CNT, local controllers.

- Specify the interfaces for your functional blocks.

- Draw the datapath using Inkspace and connect the interfaces together with wires.

- You must connect the blocks with the right interfaces.

- Determine the data width of datapath.

## The width of wire must be a multiple of 1 or 2. e.g. 2 4 8 16 32 etc... , s.t. you can modularize the circuit later and prevent further nuances.

- Usually 32 is a word = 4 bytes.
- 16 is halfword
- 8 is a byte
- 4 is halfbyte
- 2 is 2 bits
- 1 is a bit.
- It is possible to use vector width in this level for simplicity. like 4x4. 4x3 or 8x11, however when connecting with dram or sram or caches, you must reorganise the path carefully. And use FIFO to ensure data transfer efficiency.

## Trace the datapath to ensure that it works as you expected.

- Make a single cycle machine out first. Terrible in speed.
## Fast prototyping
- Do not think about complex design. Build the hardware out as fast as possible then test it.


## Datapath(Functional Blocks)
- Draw the Interfaces of the functional blocks out and then back to high level view to connect those path together.
- Create the functional block and unit test all of it with easy testbenches.
- Briefly specify the inner components of the functional block

## Optimization(Control and datapath)
- Which datapath can be shared?
- Prune the redundant datapath components out from your design.
- From the spec given, optimize the circuit.
- Whether you want to use pipeline, multicycle or folded design or somewhere in between.
- Power? Speed? or Area?
- Brute force is sometimes a good way to solve problem in hardware due to the limitation of hardware structure.
- Should forwarding units? LUTs? stall controls? bypassing units be added?
- Retiming the path? Resource sharing? Clock gating? CDC FIFO? Bus arbitration? Schedular?


## Putting it all together
- You can use verilog ,systemVerilog, bluespec or even Chisel HDL to realise your microarchitecture.
- Connect path together! Then test the final result.