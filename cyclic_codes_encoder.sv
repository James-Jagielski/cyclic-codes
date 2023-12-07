`timescale 1ns/1ps
`default_nettype none

/*
A synchronous register (batch of flip flops) with rst > ena.
*/

module encoder(clk, set, ena, rst, d1, q1);
parameter N = 1;
parameter RESET_VALUE = 0; // Value to reset to.

input wire clk, ena, rst, message;
wire [N-1:0] q1, q2, q3, q4;
output logic [N-1:0] out;



// parity check

always_comb begin:

XOR1 = q3 ^ message_data4;

end

always_ff @(posedge clk) begin
  if (rst) begin
    q1 <= RESET_VALUE;
    q2 <= RESET_VALUE;
    q3 <= RESET_VALUE;
  end
  else begin
    if (ena) begin
      q1 <= XOR1;
      q2 <= X0R1^q1;
      q3 <= q2;
    end
  end
end


// message bits

always_ff @(posedge clk) begin
  if (set1) begin
    data1 = 1'b1;
  end
  if (set2) begin
    message_data2 = 1'b1;
  end
  if (set3) begin
    message_data3 = 1'b1;
  end
  if (set4) begin
    message_data4 = 1'b1;
  end
  if (rst) begin
    message_data1 <= RESET_VALUE;
    message_data2 <= RESET_VALUE;
    message_data3 <= RESET_VALUE;
    message_data4 <= RESET_VALUE;
  end
  else begin
    if (ena) begin
      message_data1 <= data1; 
      message_data2 <= message_data1; 
      message_data3 <= message_data2;
      message_data4 <= message_data3; 
    end
  end
end


endmodule