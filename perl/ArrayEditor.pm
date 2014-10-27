package ArrayEditor;

use Moose;
use MooseX::Method::Signatures;
use Moose::Autobox;

use 5.010;
use Term::ReadKey;
use feature 'switch';

has 'array' => (isa => 'ArrayRef', is => 'rw');

sub Moose::Autobox::ARRAY::insert_elem {
    my ($self, $pos, $el) = @_;
    splice @{ $self }, $pos, 0, $el;
}

sub Moose::Autobox::ARRAY::delete_elem {
    my ($self, $pos) = @_;
    splice @{ $self }, $pos, 1;
}

method _process_key ($key) {
    given ($key) {
        when ('p') {
            $self->array->pop();
        }
        when ('q') {
           return 0; 
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
            $self->array->insert_elem( $pos, $el );
        }
        when ('d') {
            print 'delete at pos: ';
            ReadMode 0;
            my $pos = int(<>);

            $self->array->delete_elem( $pos );
        }
        default {
            warn "unrecognized command $key\n";
        }
    }
    return 1;
}


method process() {
    print '(p)op, (a)ppend, (i)nsert, (d)elete or (q)uit? ';
    ReadMode 4;
    my $key;
    while (not defined ($key = ReadKey(-1))) {
        # No key yet
    }
    say '';
    my $continue = $self->_process_key($key);
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
        say "$i\t: ", $self->array->at($i);
    }
    say '';
}

1;

