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

- _rf , _alu , _mem , _fifo , _lifo , _bus , _cache , _scoreboard , _epoch , _cnt , _ptr, StackCTR_ , MainCTR_ ;

- For reading a 2 WORD data from RF. rdData_2W_rf.
- The 1W output of ALU. result_W_alu;


- Specify the interfaces for your functional blocks.

- Draw the datapath using Inkspace or Paper and connect the interfaces together with wires.

- You must connect the blocks with the right interfaces.

- Determine the data width of datapath.

## The width of wire must be a multiple of 1 or 2. e.g. 2 4 8 16 32 etc... , s.t. you can modularize the circuit later and prevent further nuances.

- Usually 32 is a word = 4 bytes.(W)
- 16 is halfword(hW)
- 8 is a byte(B)
- 4 is halfbyte(hB)
- 2 is 2 bits(2b)
- 1 is a bit.(b)

- It is possible to use vector width in this level for simplicity. like 4x4. 4x3 or 8x11, however when connecting with dram or sram or caches, you must reorganise the path carefully. And use FIFO to ensure data transfer efficiency.

# My naming convention
1.  interfaces should be priority for each subBlocks.
2.  control_signal as __IDLE__
3.  flags as _F, status flag as _sF. (status flags are implemented in register)
4.  register as _ff
5.  I/O as _o , _i
6.  negedge triggered as _n
7.  reading from a register using register renaming as _r
8.  writing into a register using register renaming as _w
9.  Use abbreviations when naming signals. But it must be identified.
10. Buffer as _buf Pipeline register as _pipe. Delay register as _d1 or two delays as _d2 ....
11. Width of signal added into name.
12. Control signals starts with Capital letter, inner data signals starts with lowercase.

```verilog
    `define BYTE 8
    `define HALFWORD 16
    `define WORD 4*`BYTE

    function [`HALFWORD-1:0] trunc_W5b_to_hW(input [(`WORD + 5)-1:0] val32);
        trunc_32_to_16 = val32[(`WORD+5)-1:0];
    endfunction

    localparam IDLE = 4'b0000;

    wire __IDLE__ = CurState_ff == IDLE;

    reg[`HALFWORD-1:0]   weight_hW_ff;
    reg[`HALFWORD-1:0]   kernal_hW_ff;
    reg[(`WORD+5)-1:0]   temp_W5b_ff;
    reg[`WORD-1:0]       value_W_ff;

    wire[2*`WORD-1:0]    mulResult_W5b;
    wire[2*`WORD-1:0]    macResult_W5b_w;

    wire Clr;

    //DP
    //NOTE: No RST is needed for this datapath
    always@(posedge clk)
    begin: REGISTERS_INIT
        if(__IDLE__)
        begin
            weight_hW_ff <= 16'd0;
            kernal_hW_ff <= 16'd0;
            temp_W5b_ff <=  37'd0;
        end
        else
        begin
            weight_hW_ff   <= weight_hW_mem;
            kernal_hW_ff   <= kernal_hW_mem;
            temp_W5b_ff    <= macResult_W5b_w;
        end
    end


```


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