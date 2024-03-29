# Flow
1. Find db file, for our lab, search for icsl7 -> usr -> cad -> find the db file

# File system
1. Suggest the following file system.
    - Seperate files using 3 folders, syn,sim,hdl
    - Only do dc within sim
    - In sim further seperate the file into scripts,report,netlist
# CheckList
1. Remember to check whether tsmcneg13.v exists within your file
2. Check whether the path in testfixture,dc_setup and synopsys_dc_setup is correct
3. scripts can be created for easier automation.
4. Clean up files scripts can also be created to simplify the flow.
5. Check the .sdc timing constraints file, also beware that whether the cycle constraint you set is the same as the one you set within the testbench.

# Error
1. Setup in scripts must be first considered otherwise error might occur.
2. Must first check naming to clear out path for dc.
3. source file
4. Polarity problem occurs due to negedge or posedge rst. For negedge remember to use ~rst.
5. input output port problems.
6. Bit problem in FSM and Datapath.
7. Rounding problem with the wrong rounding bit.
8. Bit width problem may leads to unexpected error of FSM and signals! Please specify and Check your bit width first if you see unexpected behaviour of your waveform!
9. The problem of signed arithmetic~ Beware that you must specify both operands as signed otherwise DC or simulator will not consider them as signed value, which might yield unexpected value. Read more about signed arithmetic in verilog.
10. If an error occurs, take a look at your first error waveform signals, then trace through it with the value you expected.
11. Throw your design into vivado first and check whether it is synthesizable or not!