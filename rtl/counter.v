module counter (
  input  wire       clk,
  input  wire       rst_n,
  input  wire       en,
  output reg  [3:0] cnt,
  output wire [3:0] cnt2
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    cnt <= 4'h0;
  end
  else if (en) begin
    cnt <= cnt + 4'h1;
  end
end

sub_counter i_sub_counter (
  .clk   (clk),
  .rst_n (rst_n),
  .en    (en),
  .cnt   ()
);

endmodule
