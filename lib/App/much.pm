package App::much;

use Modern::Perl;
use Carp;
use Data::Dumper();
use Command::Runner;
use Text::MicroTemplate::DataSection;
use Types::Standard qw(Str HashRef);
use Type::Params qw(compile);
use Moo::Role;
use namespace::autoclean;

our $VERSION = "0.01";

use constant DEBUG => $ENV{MUCH_DEBUG} || 0;

sub dump {
    return Data::Dumper->new( [ $_[1] ] )->Indent(1)->Terse(1)->Sortkeys(1)
      ->Dump;
}

sub abort {
    my ( $self, $format, @args ) = @_;
    my $message = @args ? sprintf $format, @args : $format;

    Carp::confess("!! $message") if DEBUG;
    die "!! $message\n";
}

sub system {
    my ( $self, $cmd ) = @_;
    my $runner = Command::Runner->new(
        command => $cmd,
        stdout  => sub { warn "$_[0]\n" },
        stderr  => sub { warn "[E]: $_[0]\n" },
    );
    my $res = $runner->run;
    return $res;
}

sub render {
    state $check = compile( Str, HashRef );
    my ( $self, $name, $context ) = $check->(@_);
    my $mt = Text::MicroTemplate::DataSection->new( package => caller );
    return $mt->render( $name, %{$context} );
}


1;
__END__

=encoding utf-8

=head1 NAME

App::much - project creator

=head1 SYNOPSIS

    $ much new python

=head1 DESCRIPTION

App::much is a project creator for quickly starting projects for Perl, Python, and others. It's powered by an interactive menu and templates.

=head1 LICENSE

Copyright (C) Adam Stokes.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Adam Stokes E<lt>battlemidget@users.noreply.github.comE<gt>

=cut

