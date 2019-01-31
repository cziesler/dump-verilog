# dump-verilog

A script to dump a Verilog hierarchy.

## Usage

Usage: `./dump_verilog.pl [files/options]`

## Example

```sh
./dump_verilog rtl/counter.v -y rtl

Module: counter [counter]
  PORTS:
      input  clk
      output cnt
      output cnt2
      input  en
      input  rst_n
  NETS:
      clk (port )
      cnt (port reg [3:0])
      cnt2 (port [3:0])
      en (port )
      rst_n (port )
  CELLS:
      Cell: i_sub_counter
        .clk (clk)
        .cnt (cnt2)
        .en (en)
        .rst_n (rst_n)

    Module: sub_counter [counter.i_sub_counter]
      PORTS:
          input  clk
          output cnt
          input  en
          input  rst_n
      NETS:
          clk (port )
          cnt (port reg [3:0])
          en (port )
          rst_n (port )
      CELLS:

```

## License

"THE BEER-WARE LICENSE" (Revision 42):
<cody.cziesler@google.com> wrote this file.  As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return. Cody Cziesler.
