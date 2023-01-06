# When to reset a signal?
1. For every output reg, the signal must be reseted to a known value.
2. For inner datapath components, if the signal is related to Controlpath, it also has to be reseted to a known value.
3. Pure Datpath components does not really need to be reseted.


# Pros
1. Without reset, lots of area can be saved due to 