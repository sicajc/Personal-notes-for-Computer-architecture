# Debugging notes
1. To ensure the fluency of debugging, the algorithm derivation steps should be written down as clear as possible.
2. Usually a graphical description with text and steps is sufficient for debugging.
3. Charts can be used to help algorithm derivation and allows you to sometimes spot some pattern hidden within the algorithm.
4. When using the data structures, think only about the interfaces, do not care about how you implement it!
5. You can also create a personal data structure for a layer of abstraction to help building more complex algorithms.
6. Sometimes, parrallelism can be exploited to further simplified your algorithm.(Parrallel algorithm and architectures).
7. Using the DFG and unfolding techniques can sometimes helps you spot addtional parrallelism hidden within algorithm.
8. Data structures like stack and queue can be used to help you solve some hard problem.
9. You can reuse your existing code to help you implement your design faster.
10. Design library can be created. Like commonly used sorters, FIFO, basic caches, Stacks, Lists,One-shot pulse generators, Sets data structures can be implemented and used in further projects.

# DC notes & some errors
1. Remember the file directory of SDF file in testbenches
2. Scripts can be made to automate the Design compile. 01_RTL,02_GATE,03_SYN,etc....
3. Usually HDL SIM SYN SCRIPTS files are needed to help you automate your process.

# IPs
1. Once you receive an IP from others, you should first check whether the IP is written in the right way or tested extensively, otherwise it might not even be synthesizable and would create a devastating problem to your whole system.