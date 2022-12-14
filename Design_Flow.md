# Design flow

## System Level specfication and Spec
1. You must read the spec carefully. High lighting every details first.

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
- DEMUX and MUX ,RF, ALU, MEM, PIPE, FIFO, BUF, STACK, Caches ,BUS, SCOREBOARD , EPOCH, MAIN CTR, I/O interfaces, Global CNT.
- Specify the interfaces for your functional blocks.
- Draw the datapath using Inkspace and connect the interfaces together with wires.
- You must connect the blocks with the right interfaces.
- Determine the data width of datapath.
- The width of wire must be a multiple of 1 or 2. e.g. 2 4 8 16 32 etc... , s.t. you can modularize the circuit later and prevent further nuances.
- It is possible to use vector width in this level for simplicity. like 4x4. 4x3 or 8x11.
- Trace the datapath to ensure that it works as you expected.
- Make a single cycle machine out first. Terrible in speed.

## Optimization
- From the spec given, optimize the circuit.
- Whether you want to use pipeline, multicycle or folded design.
- Power? Speed? or Area?

## Fast prototyping
- Do not think about complex design.

## Datapath(Functional Block)
- Create the functional block and unit test all of it with easy testbenches.
- Draw the Interfaces of the functional blocks
- Briefly specify the inner components of the functional block

## Putting it all together
- Connect path together! Then test the final result.