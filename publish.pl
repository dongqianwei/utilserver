use File::Copy::Recursive qw[dircopy fcopy];
use File::Path;
use strict;

rmtree 'publish' if -d 'publish';
mkdir 'publish';

dircopy('lib/', 'publish') or die;
dircopy('public','publish/public') or die;
fcopy('bin/utilsrv.pl', 'publish/utilsrv.pl') or die;

print 'published!';
