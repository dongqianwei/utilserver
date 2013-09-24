package UtilServ::Plugin::Test;
use parent UtilServ::Plugin::Base;
use strict;

#set result output as file download
__PACKAGE__->modset(output => 'file');

__PACKAGE__->modpageconf(filename => 'input',
                         data => 'text');

sub proc {
    my $data = $_[1];
    $data = "echo your input data: $data, this is a test page";
};

1;
