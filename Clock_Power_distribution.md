# Clock distribution and Power distribution
1. Clock burns 30%~40% of power.
2. Skew is a serious problem, $t_{clkq}$ is not so of a problem, since buffers can be inserted to solve it.

# Clock grid Mesh
1. A rectanuger clock distribtuion, with clock rail on the edges, then distribute clock tree into the rectangular area. It has low RC delay but consumes a lot of POWER.
2. In alpha 21264, clk tree uses 4 meshes distributed out evenly to make use of such topology.
3. Multicore and SOC actually has multiple PLLs to generate clock signals in different blocks.

# Clock usage
1. In modern design, clock frequency in different modules can be different and change in run-time.
2. Different blocks might have different clock frequency.
3. philips Restle is a master of clock tree design and has some anaylic tool developed for it.

# Power
1. Power matters a lot in clock. So we need thick wire metal wire as power rail, usually the top M9 layer is extremely thick, and are used as the medium to convey $V_{dd},V_{ss}$ and clk

## IR DROP
1. IR drop in power distribution is a serious problem, $\Delta V$ in a short time of a certain region can make circuit malfunctioned. Thus, thick wire is used to combat IR drop.
2. If the power source only comes from 1 sourse, the design might have severe Power distribution problem.
3. Actually we can add large capacitance to reduce IR drop severely, this is the 2nd only place where large capacitances are GOOD for IC design, the other one is in DRAM cell design. Usually we want Capacitance to be as small as possible, however, in this case, we even use Gate capacitance to delibirately increase the total capacitance of the circuit s.t. $\Delta V$ of IR drop can be relieved.
4. gate capacitance is realised by connecting the source and drain of a MOSFET together leading to large gate capacitance which is used extensively in power distribution design.

## Electromigration
1. Wires molecues get drifted away by the current flow through it in a long time, and if $V$ is high, more molecues get drifted away, leading to short ckt or open-ckt within the IC.

## Power graph
1. The power distribution of a circuit is usually modeled as a LRC system, i.e. it osccilates. Since lots of wires generate inductance within the circuit.
