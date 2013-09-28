package UtilServ::Plugin::Test;
use parent UtilServ::Plugin::Base;
use strict;

#set result output as file download
__PACKAGE__->modset(output => 'file');

__PACKAGE__->modpageconf('userName' => 'input',
                         'content' => 'text',
                         'sex[male,female]' => 'select');

sub proc {
    my $data = $_[1];
    my ($userName, $content, $sex) = @{$data}{'userName', 'content', 'sex'};
    "Hello ". ($sex eq 'male' ? 'Mr' : 'Mis') ." $userName, your message is $content from util: Test";
};

1;
