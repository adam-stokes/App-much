requires 'Moo';
requires 'Modern::Perl';
requires 'Applify';
requires 'Command::Runner';
requires 'Type::Tiny';
requires 'Text::MicroTemplate::DataSection';
requires 'namespace::autoclean';
requires 'Carp';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

