use ArrayEditor;

use Moose;
use Moose::Autobox;
use 5.010;
use Readonly;

use Config;

Readonly my $SEPARATOR => $Config{'path_sep'};

my $arrayref = $ENV{'PATH'}->split( $SEPARATOR );

my $a = ArrayEditor->new(array => $arrayref); 
$a->edit();
say 'PATH=', $a->array->join( $SEPARATOR );

