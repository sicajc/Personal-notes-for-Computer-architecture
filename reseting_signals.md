# When to reset a signal?
1. For every output reg, the signal must be reseted to a known value. And get loaded only if the signal is ready.
2. For inner datapath components, if the signal is related to Controlpath, it also has to be reseted to a known value.
   flag_F or flag_sF
3. Pure Datpath components does not really need to be reseted.

# Pros
1. Without reset, lots of area can be saved due to the save of reset muxes in Datapath.
2. Seperate the path into control and datapath clearly to enable this.
3. From now on Status Flags should be built with Registers to enable precise inturrupts.
4. Although this would make the timing delayed by a cycle. However, result can be buffered and hold.