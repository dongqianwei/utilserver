package UtilServ::PageGen;
use parent Exporter;
use Data::Dump qw[dump];
use Mojo::Template;
use strict;

our @EXPORT = qw[pageconf pagerender];

#generate page by module settings

#page configuation storage
my %pageConf;

my $rd = Mojo::Template->new;

=head

    method: pageconf
    config module page,

    pageconf __PACKAGE__, name => 'input|str[dongqianwei]',
                          age  => 'age|num[23]',
                          intro => 'text|[]',
                          sex   => 'checkbox|[male,female]';
=cut

sub pageconf {
    my ($mod, %conf) = @_;
    $pageConf{$mod} = \%conf;
}

sub pagerender {
    my $conf = $pageConf{$_[0]} || {data => 'text'};
    print dump($conf);
}
1;

__DATA__
@@ layout.html.ep

