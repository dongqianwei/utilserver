use Mojo::Template;
use Getopt::Long;
use strict;

my ($mod, @fields);

GetOptions('name=s' => \$mod,
           'fields=s{1,}' => \@fields);

my $help = <<H;
    this tool is used to create Plugin Template
    sample:
        perl modgen --name PluginName --fields field1 field2 field3

按任意键退出。。。
H

do { print $help; <>; exit } unless defined $mod;

my $tp = <<'T';
% my ($mod, @fields) = @_;
package UtilServ::Plugin::<%=$mod%>;
use parent UtilServ::Plugin::Base;
use strict;

#set result output as file download
__PACKAGE__->modset(output => 'file');

__PACKAGE__->modpageconf(
% for my $field (@fields) {
              <%=$field%> => 'input',
% }
            );
sub proc {
    my $data = $_[1];
    my (<%=join ",", map {'$'.$_} @fields%>) = @{$data}{<%=join ",", map {"'$_'"} @fields%>};
    "";
};
T

my $rd = Mojo::Template->new;
open(my $fh, '>', $mod.'.pm') or die "can not open $mod.pm";
print $fh $rd->render($tp, $mod, @fields);
close $fh;

1;
