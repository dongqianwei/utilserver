package UtilServ::Plugin::Test;
use UtilServ::Plugin::Base;
use strict;
our @ISA = qw[UtilServ::Plugin::Base];
sub proc {
    my $data = $_[1];
    $data = "echo your input data: $data, this is a test page";
};
1;
