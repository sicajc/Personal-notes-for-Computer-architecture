# Design flow
In every parts, you should make notes, DRAW!!!! and clearly specify WTF you are doing.
## DRAW THE BLOCK DIAGRAM PLEASE
- Drawing the block diagram and specify the signals can aid your debug and allow you to explain your circuit to others.
It also allows you to review your code or modify your code faster even 1 year later or so. Since you DREW it clearly!

## DFD(Data flow diagran)
- Data flow diagram is a pretty simple but powerful method to quickly partition your design into different levels of inputs, outputs, process, data flow arrows and data stores.
- Usually DFD consists of multi-level DFDs, where we try to break problems down in a systematical and data flow way.
- Remember that no control flow should be specified in this break down process.

- Later DFD can be transformed into a strucural hiearchical diagram.

## System Level specfication and Spec
- You must read the spec carefully. High lighting every details first.

## Algorithm and Testbench
- First understand the algorithm then recreate it using basic operations,data structures and algorithms without using libraries.
- The data structure and algorithm you used must be hardware friendly. At the same time, you have to generate the testbench i.e. your golden model for your hardware.
-  DISCUSS WITH OTHERS
-  Usually the efficiency of a certain implmentation is dictated by the Algorithm you used.
-  Algorithm 70% with the RIGHT HW 30%.
e.g. No one would ever run non-parralizable algorithm on GPU = =, this is handled by OoO CPU. However, parrallel algorithm works fine on GPU but terrible in OoO CPU. Use Amdahl's law to first examine the speedup of your design idea you want to scale up.

> This step should be carefully examined and is the most important step, do not miss the corner cases. Spending a day on this step is alright.

## Decision tress and Decision tables
1. When modeling complex programming logics, drawing out a decision table or decision tree might be a great option to identify all the possible outcomes of the logic you are going to make.
2. Decision tables consists of inputs, outputs, and check and table.
3. Decision trees are tree structures with decision nodes as conditions and outputs nodes as actions, is also a great way to represent your complex thought.
4. Doing one of these two in small decision making design can prevent yourself from missing corner cases.

## ASMD(Control)
- Specify the WORD(Width of your datapath), the WORD is usually determined by the maximum width of the memory. For example, MIPS architecture has a 32-bit word. Doing so can at least ensure the data be aligned correctly, also simplify your design if you want to optimize your circuit.
- Convert the algorithm you just derived to ASMD chart to have a clear view about which components are needed.
- Also it specifies the states and datapath components needed for further simplification and recombination.
- At the same time, perform FSM factorization(Partition the main CTR into smaller local CTRs) to further simplify the logic of controller.
- Using the concept of multi-level FSMs can simplify your design a lot and makes it clear for others and yourself.
> DISCUSS WITH OTHERS

## Microarchitecture
> DIFFERENT MICROARCHITECTURE IMPACTS THE PERFORMANCE.
- Which architecture would you like to use?
- OoO? Single cycle? Multi-cycle? Pipelined? DAE? Multi-Core? SuperScalar? Systolic? VLIW? They all have their own tradeoffs.
## Datapath(Microarchitecture)
> The priniple of Hierarchical design.
- Data type of your circuit should be determined ahead. What kind of data you are processing matters a lot. Is it floating point value? Fixed-point? Or signed integer? Unsigned integer? or even binary?

- Create and DRAW the datapath from the ASMD chart you just derived. Visualize the main components needed.(RF)(ALU)(MEM) etc...

- DEMUX and MUX ,RF, ALU, MEM, PIPE, FIFO, BUF, STACK, Caches ,BUS, SCOREBOARD ,ScratchBoard,EPOCH, MAIN CTR, I/O interfaces, Global CNT, local controllers.

- _rf , _alu , _mem , _fifo , _lifo , _bus , _cache , _scoreboard , _epoch , _cnt , _ptr, StackCTR_ , MainCTR_ ;

- For reading a 2 WORD data from Matrix RF. naming : rdData_2W_matrix_rf. means a 2 word data read out from matrix RF

- The 1W output of ALU. W_result_alu means reading 1 word data from alu.

- Specify the interfaces for your functional blocks.

- Draw out the RULE(Mimicked from BlueSpec systemVerilog) for mid Complex logic implementation.

- Glue the datapath components using Paper drawings.

- You must connect the blocks with the right interfaces.

- Determine the data width of datapath.

- If possible, DISCUSS WITH OTHERS.

* If you are experienced, this might take around an hour or two to complete.

## The width of wire must be a multiple of 1 or 2. e.g. 2 4 8 16 32 etc... , s.t. you can modularize the circuit later to prevent further nuances.

- Usually 32 is a word = 4 bytes.(W)
> However, depends on the data width of the Mem you use, this might vary.
- 16 is halfword(hW)
- 8 is a byte(B)
- 4 is halfbyte(hB)
- 2 is 2 bits(2b)
- 1 is a bit.(b)

- It is possible to use vector width in this level for simplicity. like 4x4. 4x3 or 8x11, however when connecting with dram or sram or caches, you must reorganise the path carefully. And use FIFO to ensure data transfer efficiency.

# My naming convention
0.  interfaces should be the priority for each subBlocks that is going to connect to other subBlocks.e.g. dataOut_rq, dataOut_data,dataOut_rdy. All belongs to dataOut interface.
1.  control_signal as ```state_idle```
2.  flags as _F, status flag as _sF. (status flags are implemented in register)
3.  register as _ff
4.  I/O as o_ , i_
5.  negedge triggered as _n
6.  reading from a register using register renaming as _r
7.  writing into a register using register renaming as _w
8.  Use abbreviations when naming signals. But it must be identified.
9.  Buffer as _buf Pipeline register as _pipe. Delay register as _d1 or two delays as _d2 ....
10. Width of signal added into name.
11. Control signals starts with Capital letter, inner data signals starts with lowercase.

```verilog
module(
    input[`HALFWORD-1:0] i_weight_hW,
    input[`HALFWORD-1:0] i_kernal_hW,
    input[`HALFWORD-1:0] i_bias_hW,
    output[`HALFWORD-1:0] reg o_result_hW_ff;
);
    `define BYTE 8
    `define HALFWORD 16
    `define WORD 4*`BYTE

    function [`HALFWORD-1:0] trunc_W5b_to_hW(input [(`WORD + 5)-1:0] val32);
        trunc_32_to_16 = val32[(`WORD+5)-1:0];
    endfunction

    localparam IDLE = 4'b0000;

    wire state_idle = CurState_ff == IDLE;

    reg[`HALFWORD-1:0]   weight_hW_ff;
    reg[`HALFWORD-1:0]   kernal_hW_ff;
    reg[(`WORD+5)-1:0]   temp_W5b_ff;
    reg[`WORD-1:0]       value_W_ff;

    wire[2*`WORD-1:0]    mulResult_W5b;
    wire[2*`WORD-1:0]    macResult_W5b_w;

    wire ClrData = state_idle;

    //DP
    //NOTE: No RST is needed for this datapath
    always@(posedge clk)
    begin: REGISTERS_INIT
        if(state_idle)
        begin
            weight_hW_ff <= i_weight_hW;
            kernal_hW_ff <= i_kernal_hW;
            temp_W5b_ff <=  i_bias_hW;
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
- Do not think about complex design. Draw(Makes Debug and Extension Easier) and build the hardware out as fast as possible then test it.

## Datapath(Functional Blocks)
- Draw the Interfaces of the functional blocks out and then back to high level view to connect those path together.
- Create the functional block and unit test all of it with easy testbenches.
- Briefly specify the inner components of the functional block.

## Optimization(Control and datapath)
- Which datapath can be shared?
- Prune the redundant datapath components out from your design.
- From the spec given, optimize the circuit.
- Power? Speed? or Area?
- Whether you want to use pipeline, multicycle or folded design or somewhere in between.
- Brute force is sometimes a good way to solve problem in hardware due to the Parrallism and nature of hardware structure.
- Should forwarding units? LUTs? stall controls? bypassing units be added?
- Retiming the path? Resource sharing? Clock gating? CDC FIFO? Bus arbitration? Schedular?


## Putting it all together
- You can use verilog ,systemVerilog, bluespec or even Chisel HDL to realise your microarchitecture.
- Connect path together! Then test the final result.

## Performance Evaluation
1. Use Performance = PSA , Power(P), Speed(S), Area(A). Remember, sometimes generating more identical hardware might not be always larger due to the optimization of design compiler~


## Debug Notes
### Problems of algorithm
1. Retrace or recheck the algorithm you use, did you miss some important info? Or did you misunderstand the spec?
2. Discuss with others about your thought of the algorithm. Trace it again! Or you some High-level language to proof that it is valid and working!
### Hardware and problems of microarchtiecture
1. Check for each always block, have you assigned the wrong signal value?
2. Check for bit Width declaration, have you assigned the wrong bit Width to your signal?
3. Check for arithmetic. Which data type are you trying to use? Are the operands of the same data type?
4. Check for possibility of Overflow. Did you assign enough bit width to hold your data?
5. Check for FSM you implemented, did you perform the transition correctly?
6. Check for control signals conditions. Did you consider every cases.
7. Check for sequential assignment and combinational assignment, did you mix use them?
8. Check for Concatenation and Sign-extension error, did you forget to align or sign-extended the value?
9. Check for data alignment. When sharing registers, this might occurs, i.e. fitting a 8 bit data into 32 bit register, sign-extension has to be made if it is a signed value or depends on your representation. {12'b0,value,12'b0}, value is a Byte
10. Check for Sampling rate if Real-time I/O is needed.
11. Check for VIVADO ERRORS and WARNINGS, this can save you lots of time.
12. Check for VIVADO SYNTHESIS ERROR AND WARNINGS, this also can save you lots of time before using DC.
13. Beware to make changes on the paper you scratched whenever your try to modify your code.

### Problems in DC
1. Suggest compile your design first in medium mode first, otherwise if you compile it in high or compile_ultra first, some part of your circuit might get optimized which might or might not leads to functional errors.
2. Forget to add -load_delay net leads to wrong annotation rate, remember to add the following command to check for it when doing gate level simulation.

```
    -diag=sdf:verbose
```
