# Interfaces
1. specify these with interface_data_i;

# Guards
1. Combinational circuit which prevent other circuits from doing something.

# Rules and method(FSM and Combinational output)
1. Combinational circuit that takes input and give an output according to the current state.
```verilog
always@(*)
begin
    c = a + b;
    d = c + a; // This is possible as long as you know the rule. Or the combinational block you want to implement.
end
```