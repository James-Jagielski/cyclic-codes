`timescale 1ns/1ps
`default_nettype none

/*
A synchronous register (batch of flip flops) with rst > ena.
*/



module encoder(clk, set, ena, rst, d, in0, in1, in2, in3, in4, in5, in6, in7);
parameter N = 1;
parameter RESET_VALUE = 0; // Value to reset to.
input wire [3:0] s;
input wire clk, ena, rst, set;
input wire [N-1:0] d, data1, data2, data3, in0, in1, in2, in3, in4, in5, in6, in7;
output logic [N-1:0] syndrome_data1, syndrome_data2, syndrome_data3, syndrome_data4, out;




// syndrome bits

always_comb begin:
data1 = syndrome_data3 ^ d;
data2 = syndrome_data3 ^ syndrome_data1;
syndrome_data2 = data2;
syndrome_data3 = data3;
end

always_ff @(posedge clk) begin
  if (rst) begin
    syndrome_data1 <= RESET_VALUE;
    syndrome_data2 <= RESET_VALUE;
    syndrome_data3 <= RESET_VALUE;
  end
  else begin
    if (ena) begin
      syndrome_data1 <= data1; 
      syndrome_data2 <= data2; 
      syndrome_data3 <= data3;
    end
  end
end

// Mux
wire [N-1:0] mux0_out;
mux8 #(.N(N)) MUX0 (.in0(in0), .in1(in1), .in2(in2), .in3(in3), 
.in4(in4), .in5(in5), .in6(in6), .in7(in7), .s(s[2:0]), .out(mux0_out));

// buffer shift register

always_ff @(posedge clk, posedge rst)
  if (rst) begin
    q <= 0;
  end
  else if (set) begin
    q <= d;
  end
  else begin
  q <= {q[N-2:0],sin};
  end
  assign sout = q[N-1];

  // XOR 

  assign out = mux0_out^ sout;

endmodule