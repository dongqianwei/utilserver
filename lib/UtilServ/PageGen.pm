package UtilServ::PageGen;
use parent Exporter;
use Data::Dump qw[dump];
use Mojo::Template;
use Carp;
use Dancer;
use strict;

our @EXPORT = qw[pageconf pagerender];

#generate page by module settings

#page configuation storage
my %pageConf;

my $base = 'public/templates/';

my $rd = Mojo::Template->new;

=head

    method: pageconf
    config module page,

    pageconf __PACKAGE__, name[dongqianwei] => 'input',
                          age[23]  => 'age',
                          intro => 'text',
                          sex[male,female]   => 'checkbox';
=cut

sub pageconf {
    my ($mod, %conf) = @_;
    $pageConf{$mod} = \%conf;
}

sub pagerender {
    my $conf = $pageConf{$_[0]} || {data => 'text'};
    my $content;
    for my $name (keys %{$conf}) {
        info "render data: $name";
        $conf->{$name} eq 'text' ?
        $content .= $rd->render_file($base.'textarea.ep', $name) :
        $conf->{$name} eq 'input' ?
        $content .= $rd->render_file($base.'input.ep', $name) :
        croak("not yet implemented");
    }
    $rd->render_file($base.'layout.ep', {head=>$_[0],content=>$content});
}
1;
