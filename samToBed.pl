#!/usr/bin/perl
use warnings;
use strict;

while(<>){
	next if(/^@/);#Skip header
	chomp;
	#(Query,flag,ref,pos,mapq,cigar,mrnm,mpos,isize,seq,quak,opt)
	#my ($name, $flag, $slice_name, $pos, $mapq, $cigar, $mrnm, $mpos, $isize, $read, $quak, $opt) = split("\t");
	my ($name, $flag, $slice_name, $pos, $mapq, undef, undef, undef, undef, $read) = split("\t");
	next if $flag & 4;#Unmapped read. 
	#Query strand is in the 5th(index == 4) bit...  I'm assuming the reference strand never changes
	#i.e. 2*4 = 16 bitwise 16 & 16 == 16 else 0
	my $strand = ($flag & 16) ? '-' : '+';
	my $start = $pos - 1; # transform from one-based to zero-based
	my $stop = $start + length($read) - 1 + 1; # add 1 in stop position => [start,stop)
	my $seq_region_name = $slice_name;
	print join("\t", ($seq_region_name, $start, $stop, $name, $mapq, $strand))."\n"; #add 1 in stop position => [start,stop)
}
1;
