#!/usr/bin/env perl

use strict;
use warnings;

use Verilog::Getopt;
my $opt = new Verilog::Getopt;
@ARGV = $opt->parameter(@ARGV);

use Verilog::Netlist;
my $nl = new Verilog::Netlist(
  options => $opt,
  link_read_nonfatal => 1,
);

foreach my $file (@ARGV) {
  $nl->read_file(filename => $file);
}

$nl->link();

foreach my $mod ($nl->top_modules_sorted) {
  show_hier($mod, "", "", "");
}

sub show_hier {
  my ($mod, $indent, $hier, $cellname) = @_;

  if (!$cellname) {
    $hier = $mod->name;
  } else {
    $hier .= ".$cellname";
  }
  printf("\n");
  printf($indent . "%s [%s]\n", "Module: " . $mod->name, $hier);

  printf($indent . "  PORTS:\n");
  foreach my $port ($mod->ports_sorted) {
    my $dir =
      $port->direction eq "in"  ? "input" :
      $port->direction eq "out" ? "output" : $port->direction;
    printf($indent . "      %-6s %s\n", $dir, $port->name);
  }

  printf($indent . "  NETS:\n");
  foreach my $net ($mod->nets_sorted) {
    printf($indent . "      %s (%s)\n", $net->name, $net->decl_type . " " .$net->data_type);
  }

  printf($indent . "  CELLS:\n");
  foreach my $cell ($mod->cells_sorted) {
    printf($indent . "      Cell: %s\n", $cell->name);
    foreach my $pin ($cell->pins_sorted) {
      printf($indent . "        .%s (%s)\n", $pin->name, $pin->net->name);
    }
  }
  foreach my $cell ($mod->cells_sorted) {
    if ($cell->submod) {
      show_hier($cell->submod, $indent . "    ", $hier, $cell->name);
    }
  }
}

