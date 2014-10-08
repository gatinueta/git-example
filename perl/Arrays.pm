package Arrays;

use Moose;
use MooseX::Method::Signatures;
use Moose::Autobox;

use 5.010;
use Term::ReadKey;
use feature 'switch';

has 'array' => (isa => 'ArrayRef', is => 'rw');

method process() {
    print '(p)op, (a)ppend, (i)nsert, (d)elete or (q)uit? ';
    ReadMode 4;
    my $key;
    while (not defined ($key = ReadKey(-1))) {
        # No key yet
    }
    say '';
    my $continue = 1;
    given ($key) {
        when ('p') {
            pop @{ $self->array };
        }
        when ('q') {
            $continue = 0;
        }
        when ('a') {
            print 'append: ';
            ReadMode 0;
            my $el = <>;
            chomp $el;
            $self->array->push($el);
        }
        when ('i') {
            print 'insert at pos: ';
            ReadMode 0;
            my $pos = int(<>);
            print 'what: ';
            my $el = <>; 
            chomp $el;

            splice @{ $self->array }, $pos, 0, $el;
        }
        when ('d') {
            print 'delete at pos: ';
            ReadMode 0;
            my $pos = int(<>);

            splice @{ $self->array }, $pos, 1;
        }
        default {
            warn "unrecognized command $key\n";
        }
    }
    ReadMode 0;
    return $continue;
}

method edit() {
    $self->show();
    while ($self->process()) {
        $self->show();
    }
}

method show() {
    foreach my $i (0 .. $self->array->length-1) {
        say "$i\t: ", $self->array->[$i];
    }
    say '';
}

1;

