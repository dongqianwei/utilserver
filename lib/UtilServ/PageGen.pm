package UtilServ::PageGen;
use parent Exporter;
use Data::Dump qw[dump];
use Mojo::Template;
use Carp;
use Dancer;
use Module::Find;
use strict;

our @EXPORT = qw[pageconf pagerender page_render_result];

#generate page by module settings

#page configuation storage
my %pageConf;

my $base = 'public/templates/';

my $rd = Mojo::Template->new;

=head

    method: pageconf
    config module page,

    pageconf __PACKAGE__, name[dongqianwei] => 'input',
                          age[23]  => 'input',
                          intro => 'text',
                          sex[male,female]   => 'select';
=cut

sub pageconf {
    my ($mod, %conf) = @_;
    $pageConf{$mod} = \%conf;
}

sub pagerender {
    my $conf = $pageConf{$_[0]};
    my $content;
    for my $name (keys %{$conf}) {
        info "render data: $name";
        $conf->{$name} eq 'text' ?
        $content .= $rd->render_file($base.'textarea.ep', $name) :
        $conf->{$name} eq 'input' ?
        $content .= $rd->render_file($base.'input.ep', $name) :
        $conf->{$name} eq 'select' ?
        $content .= $rd->render_file($base.'select.ep', $name) :
        croak("not yet implemented");
    }
    $rd->render_file($base.'layout.ep', {head=>$_[0],content=>$content});
}

sub page_render_result {
    my ($mod, $content) = @_;
    $rd->render_file($base.'result.ep', {mod => $mod, content => $content});
}

sub sitemap {
    my @plugins = grep {$_ ne 'Base'} map {s/^.*:([^:]+)$/$1/r} findsubmod UtilServ::plugin;
    $rd->render_file($base.'sitemap.ep', @plugins);
}

1;
