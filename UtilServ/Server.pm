package Server;
use Dancer;
use strict;
use Module::Load::Conditional 'can_load';

sub get_mod {
    my $mod = shift;
    "UtilServ::Plugin::$mod";
}

sub try_load {
    my $module = shift;
    info "load module: $module";
    $module = get_mod $module;
    can_load(modules => {$module=>''})
}

get '/app/:module' => sub {
    my $module = param 'module';
    try_load $module or
    return "$module can't be loaded";

    my $mod = get_mod $module;
    return "$module did not inherate Plugin::Base!"
        unless $mod->isa('UtilServ::Plugin::Base');

    $mod->page;
};

post '/app/:module' => sub {
    my $data = param 'data';
    my $mod = get_mod param 'module';
    $mod->proc($data);
};
