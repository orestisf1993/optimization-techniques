#!/usr/bin/env perl
use strict;
use File::stat;
my $syntax = "Syntax: $0 <file> <file>\n";
@ARGV == 2 or die $syntax;
chomp(my $file1 = shift);
chomp(my $file2 = shift);
-f $file1 or die "File not found ($file1)!\n";
-f $file2 or die "File not found ($file2)!\n";
if ((stat($file1)->mtime)>(stat($file2)->mtime))
{
unlink($file2)
}
__END__
