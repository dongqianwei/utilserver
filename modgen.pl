use Mojo::Template;
use strict;

my $tp = <<'T';
% my $mod = shift;
package UtilServ::Plugin::<%=$mod%>;
use parent UtilServ::Plugin::Base;
use strict;

#set result output as file download
__PACKAGE__->modset(output => 'file');

__PACKAGE__->modpageconf(data => 'text');

sub proc {
    my $data = $_[1];
    my ($data) = @{$data}{'data'};
    $data;
};
T

my $rd = Mojo::Template->new;
print $rd->render($tp, 'Test');

1;
