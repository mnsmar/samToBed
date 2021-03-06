#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;

use lib '/home/mns/lib/perl/class/v7.0';
use MyBio::Data::File::SAM;

# Read command options
my $time = time;
my $help;
GetOptions(
        'h'    => \$help,
) or usage();
usage() if $help;


my $sam_file = shift or usage();

my $sam_parser = MyBio::Data::File::SAM->new({FILE => $sam_file});
while (my $record = $sam_parser->next_record) {
	if ($record->is_mapped) {
		print join("\t", ($record->rname, $record->start, $record->stop + 1, $record->qname, $record->mapq, $record->strand_symbol))."\n";
	}
}

###########################################
# Subroutines used
###########################################
sub usage {
	print "\nUsage:   $0 <options> sam_file\n\n".
	      "If sam_file has the suffix .gz it is assumed to be gzipped\n".
	      "Options:\n".
	      "        -h                   print this help\n\n";
	exit;
}