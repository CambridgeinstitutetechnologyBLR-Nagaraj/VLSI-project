`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveform
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
  end

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate DUT
  tt_um_comp8 user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin

    // Initialize signals
    clk     = 0;
    rst_n   = 0;
    ena     = 1;
    ui_in   = 0;
    uio_in  = 0;

    // Apply reset
    #10;
    rst_n = 1;

    //=====================================
    // Test 1 : Equal
    //=====================================
    ui_in  = 8'd5;
    uio_in = 8'd5;

    #10;

    $display("--------------------------------");
    $display("TEST 1 : EQUAL");
    $display("ui_in   = %0d", ui_in);
    $display("uio_in  = %0d", uio_in);
    $display("uo_out  = %0d", uo_out);

    //=====================================
    // Test 2 : Greater Than
    //=====================================
    ui_in  = 8'd10;
    uio_in = 8'd3;

    #10;

    $display("--------------------------------");
    $display("TEST 2 : GREATER THAN");
    $display("ui_in   = %0d", ui_in);
    $display("uio_in  = %0d", uio_in);
    $display("uo_out  = %0d", uo_out);

    //=====================================
    // Test 3 : Less Than
    //=====================================
    ui_in  = 8'd2;
    uio_in = 8'd9;

    #10;

    $display("--------------------------------");
    $display("TEST 3 : LESS THAN");
    $display("ui_in   = %0d", ui_in);
    $display("uio_in  = %0d", uio_in);
    $display("uo_out  = %0d", uo_out);

    //=====================================
    // Test 4 : Equal
    //=====================================
    ui_in  = 8'd15;
    uio_in = 8'd15;

    #10;

    $display("--------------------------------");
    $display("TEST 4 : EQUAL");
    $display("ui_in   = %0d", ui_in);
    $display("uio_in  = %0d", uio_in);
    $display("uo_out  = %0d", uo_out);

    // Finish simulation
    #20;
//    $finish;

  end

endmodule
