`timescale 1ns/1ps

module shift_register_tb;

```
reg clk;
reg reset;
reg serial_in;

wire [3:0] q;

shift_register uut (
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .q(q)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    // Generate VCD waveform
    $dumpfile("simulation/waveform.vcd");
    $dumpvars(0, shift_register_tb);

    // Reset
    reset = 1;
    serial_in = 0;
    #10;

    // Release reset
    reset = 0;

    // Shift 1
    serial_in = 1;
    #10;

    // Shift 0
    serial_in = 0;
    #10;

    // Shift 1
    serial_in = 1;
    #10;

    // Shift 1
    serial_in = 1;
    #10;

    // Shift 0
    serial_in = 0;
    #10;

    // Shift 1
    serial_in = 1;
    #10;

    $finish;

end

initial begin
    $monitor(
        "Time=%0t | Reset=%b | Serial_In=%b | Q=%b",
        $time, reset, serial_in, q
    );
end
```

endmodule
