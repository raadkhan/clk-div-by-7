// specify simulation timescape
`timescale 1ns/1ps

module clkdivby7_tb;

    logic clk_in, rst, clk_out;

    // behold, the power of implicit port connection
    clkdivby7 DUT(.*);

    // initialize input signals
    initial begin
        {clk_in, rst} = 2'b11;
    end

    // simulate input clock
    always begin
        #5 clk_in = ~clk_in;
    end

    initial begin
        #5; // release reset after 5 steps
        rst = 0; // verify by waveform inspection
    end

endmodule