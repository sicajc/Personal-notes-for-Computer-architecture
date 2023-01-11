module carry_save_adder #(parameter N=8) (
    input wire [N-1:0] a,
    input wire [N-1:0] b,
    output wire [N-1:0] sum,
    output wire [N:0]   carry
);

wire [N-1:0] gi, pi;
genvar i;

generate
  for(i=0; i<N; i = i + 1) begin : gen_c
    if(i==0) begin
      assign gi[i] = a[i] & b[i];
      assign pi[i] = a[i] ^ b[i];
    end else begin
      assign gi[i] = (a[i] & b[i]) | (a[i] & carry[i-1]) | (b[i] & carry[i-1]);
      assign pi[i] = (a[i] ^ b[i]) ^ carry[i-1];
    end
  end
endgenerate

assign sum = pi;
assign carry[0] = gi[0];
generate
  for(i=1; i<=N; i = i + 1) begin : gen_cout
    assign carry[i] = gi[i] | (pi[i-1] & carry[i-1]);
  end
endgenerate

endmodule
