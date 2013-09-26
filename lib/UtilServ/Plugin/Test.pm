package UtilServ::Plugin::Test;
use parent UtilServ::Plugin::Base;
use strict;

#set result output as file download
__PACKAGE__->modset(output => 'file');

__PACKAGE__->modpageconf('userName' => 'input',
                         'content' => 'text');

sub proc {
    my $data = $_[1];
    my ($userName, $content) = @{$data}{'userName', 'content'};
    "Hello $userName, your message is $content from util: Test";
};

1;
