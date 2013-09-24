package UtilServ::Plugin::Base;
use UtilServ::Config;
use UtilServ::PageGen;
use Carp;
use subs qw[_modpagerender];
use strict;

=head

    method : proc

    plugin must implement this method

=cut

sub proc {
    my $class = ref $_[0] ? ref $_[0] : $_[0];
    die "plugin $class must implement proc method";
}

=head

    method : page
    default page which contains a textarea to send data

    you can override the ui,
    but promise all data could be accessd by key 'data'

    data will be passed to method porc

=cut

sub page {
    _modpagerender @_;
}

=head

    method: modset, modget
    config modules

=cut

sub modset {
    croak "params num must be 3" unless @_ == 3;
    confset @_;
}

sub modget {
    croak "params num must be 3" unless @_ == 2;
    confget @_;
}

=head
    method:modpageconf
    __PACKAGE__->modpageconf();
=cut

sub modpageconf {
    pageconf @_;
}

#render page
sub _modpagerender {
    pagerender @_;
}

1;
