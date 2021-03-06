#!/usr/bin/perl -w

use feature qw(say);

my @chapters =
  qw(zero cats functors transformations
     limits adjointness representables);

open(my $outh, '>', "skel.tex") or die $!;
say $outh "% !TEX program = lualatex";
say $outh "% !TEX root = ./CT.tex";
say $outh "\n% *** file generated by \'$0\' ***";
foreach my $ch (@chapters) {
  my $in = "../$ch/$ch.tex";
  if (-f $in) {
    say $outh "\n% % %";
    open(my $inh, '<', $in) or die $!;
    while ($_ = <$inh>) {
      $_ =~ s/^\s+//; $_ =~ s/\s+$//;
      if ($_ =~ /^\\title/) {
        $_ =~ s/title/chapter/;
        say $outh $_;
      }
      if ($_ =~ /^\\input\{includes/) {
        $_ =~ s/\\input\{(.+)\}/\\input\{..\/$ch\/$1\}/;
        say $outh $_;
      }
    }
    close($inh);
  } else {
    say ":: \'$in\' not found!";
  }
}
close($outh);

