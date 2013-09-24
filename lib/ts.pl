package A;
sub pr{print @_};
1;

package B;
use parent 'A';
__PACKAGE__->pr();
1;
