# 4-Bit Shift Register Using Verilog HDL

## 📌 Project Description

A **Shift Register** is a sequential digital circuit used to store and shift binary data. It is made up of flip-flops connected in series, where the stored data moves by one position on every active clock edge.

This project implements a **4-bit Serial-In Serial-Out (SISO) Shift Register using Verilog HDL**. The design includes a reset input, serial data input, clock input, and a 4-bit register output.

The project also includes a testbench to verify the design and a simulation waveform that can be viewed using GTKWave.

## 🔌 Inputs and Outputs

### Inputs

* `clk` – Clock signal
* `reset` – Active-high reset
* `serial_in` – Serial data input

### Output

* `q` – 4-bit shifted data output

## ⚙️ Working Principle

The shift register stores four bits of data. On every positive edge of the clock, the existing data shifts by one position and the new serial input is loaded into the register.

The shifting operation is:

```text
q[3] ← q[2]
q[2] ← q[1]
q[1] ← q[0]
q[0] ← serial_in
```

For example, starting with `0000`:

```text
Serial Input = 1 → 0001
Serial Input = 0 → 0010
Serial Input = 1 → 0101
Serial Input = 1 → 1011
```

## 📊 Operation Table

| Reset | Serial In | Operation                |
| ----- | --------- | ------------------------ |
| 1     | X         | Reset register to `0000` |
| 0     | 0         | Shift in `0`             |
| 0     | 1         | Shift in `1`             |

## 💻 Verilog Design

File:

```text
src/shift_register.v
```

```verilog
module shift_register (
    input clk,
    input reset,
    input serial_in,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000;
        else
            q <= {q[2:0], serial_in};
    end

endmodule
```

## 🧪 Testbench

File:

```text
testbench/shift_register_tb.v
```

The testbench generates a clock, applies reset, and then shifts a sequence of serial input bits into the register.

```verilog
`timescale 1ns/1ps

module shift_register_tb;

    reg clk;
    reg reset;
    reg serial_in;

    wire [3:0] q;

    // Instantiate Shift Register
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

        // Generate waveform
        $dumpfile("simulation/waveform.vcd");
        $dumpvars(0, shift_register_tb);

        // Initial values
        reset = 1;
        serial_in = 0;

        #10;

        // Release reset
        reset = 0;

        // Shift in 1
        serial_in = 1;
        #10;

        // Shift in 0
        serial_in = 0;
        #10;

        // Shift in 1
        serial_in = 1;
        #10;

        // Shift in 1
        serial_in = 1;
        #10;

        // Shift in 0
        serial_in = 0;
        #10;

        // Shift in 1
        serial_in = 1;
        #10;

        $finish;

    end

    // Display simulation values
    initial begin
        $monitor(
            "Time=%0t | Reset=%b | Serial_In=%b | Q=%b",
            $time, reset, serial_in, q
        );
    end

endmodule
```

## ▶️ Simulation

This project can be simulated using **Icarus Verilog** and the waveform can be viewed using **GTKWave**.

### Step 1: Compile

From the project directory:

```bash
iverilog -o shift_register_sim src/shift_register.v testbench/shift_register_tb.v
```

### Step 2: Run Simulation

```bash
vvp shift_register_sim
```

This generates:

```text
simulation/waveform.vcd
```

### Step 3: Open Waveform

```bash
gtkwave simulation/waveform.vcd
```

Add the following signals in GTKWave:

```text
clk
reset
serial_in
q
```

## 📈 Expected Simulation

After reset, the register starts at:

```text
Q = 0000
```

Then the serial data is shifted into the register on every positive clock edge.

For the input sequence:

```text
1 → 0 → 1 → 1
```

the register becomes:

```text
0000
0001
0010
0101
1011
```

The waveform should show the `q` output changing only on the active clock edges.

## 📋 Expected Terminal Output

The exact timestamps depend on the testbench, but the register values should follow this pattern:

```text
Reset = 1 → Q = 0000
Serial In = 1 → Q = 0001
Serial In = 0 → Q = 0010
Serial In = 1 → Q = 0101
Serial In = 1 → Q = 1011
```

## 📊 Simulation Waveform

After running the simulation, take a screenshot of the GTKWave output and save it as:

```text
simulation/waveform.png
```

You can then add it to the README:

```markdown
## Simulation Waveform

![Shift Register Simulation](simulation/waveform.png)
```

## 🎯 Applications

Shift registers are commonly used in:

* Serial data transfer
* Serial-to-parallel conversion
* Parallel-to-serial conversion
* Temporary data storage
* Digital delay circuits
* Data communication
* Digital systems
* Microprocessors

## 🛠️ Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* Git
* GitHub

## ✅ Conclusion

The **4-bit Shift Register** was successfully designed using Verilog HDL and verified using a testbench.

The simulation demonstrates that the input data is shifted by one position on every positive edge of the clock. The reset signal successfully initializes the register to `0000`.

This project demonstrates the complete digital design flow:

**Verilog Design → Testbench → Simulation → Waveform → GitHub**

## 👨‍💻 Author

**Your Name**

GitHub: **Your GitHub Username**
