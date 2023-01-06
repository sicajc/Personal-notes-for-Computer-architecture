module coding#(
           parameter BYTE = 8,
           parameter WORD = 4*BYTE,
           parameter DATA_WIDTH = WORD
       )(
           //Basic signals
           input clk_i,
           input rst_ni,

           //Interfaces
           //start
           input[DATA_WIDTH-1:0]      start_data_i,
           input                      start_en_i,
           output                     start_rdy_o,

           //getResult
           input                      getResult_en_i,
           output reg                 getResult_rdy_ff_o,
           output reg[DATA_WIDTH-1:0] getResult_data_ff_o
       );








endmodule
