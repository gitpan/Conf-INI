package Conf::INI;

use 5.006;
use strict;
use Tie::Cfg;

our $VERSION='0.04';

sub new {
  my $class=shift;
  my $file=shift;

  my $self;

  tie my %ini, 'Tie::Cfg', READ => $file, WRITE => $file;
  $self->{"ini"}=\%ini;

  bless $self,$class;

return $self;
}

sub DESTROY {
  my $self=shift;
  untie %{$self->{"ini"}};
}

sub set {
  my $self=shift;
  my $var=shift;
  my $val=shift;

  my ($section,$var)=split /[.]/,$var,2;
  if (not defined $var) {
    $var=$section;
    $section="!!Conf::INI!!default!!";
  }

  $self->{"ini"}->{$section}{$var}=$val;
}

sub get {
  my $self=shift;
  my $var=shift;

  my ($section,$var)=split /[.]/,$var,2;
  if (not defined $var) {
    $var=$section;
    $section="!!Conf::INI!!default!!";
  }

return $self->{"ini"}->{$section}{$var};
}

sub variables {
  my $self=shift;
  my @vars;

  for my $k (keys %{$self->{"ini"}}) {
    if (ref($self->{"ini"}->{$k}) eq "HASH") {
      for my $v (keys %{$self->{"ini"}->{$k}}) {
	if ($k eq "!!Conf::INI!!default!!") {
	  push @vars,$v;
	}
	else {
	  push @vars,"$k.$v";
	}
      }
    }
    else {
      push @vars,$k;
    }
  }
return @vars;
}

1;

__END__

=head1 NAME

Conf::INI - a .ini file backend for conf

=head1 ABSTRACT

C<Conf::INI> is an INI file (windows alike) backend for Conf. 
It handles a an INI file with identifiers that are 
assigned values. Identifiers with a '.' (dot) in it,
are divided in a section and a variable.

=head1 Description

This module uses Tie::Cfg for reading and writing .INI files.
Each call to C<set()> will B<not> immediately result in a 
commit to the .ini file.

Each call C<set()> will immediately result in a commit 
to the database.

=head2 C<new(filename) --E<gt> Conf::INI>

Invoked with a valid filename, 
will return a Conf::INI object that is connected to
this file.

=head2 DESTROY()

This function will untie from the ini file.

=head2 C<set(var,value) --E<gt> void>

Sets config key var to value. If var contains a dot (.),
the characters prefixing the '.' will represent a section
in the .ini file. Sample:

  $conf->set("section.var","value")

will result in:

  [section]
  var=value

=head2 C<get(var) --E<gt> string>

Reads var from config. Returns C<undef>, if var does not
exist. Returns the value of configuration item C<var>,
otherwise.

=head2 C<variables() --E<gt> list of strings>

Returns all variables in the configuraton backend.

=head1 SEE ALSO

L<Conf|Conf>.

=head1 AUTHOR

Hans Oesterholt-Dijkema, E<lt>oesterhol@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Hans Oesterholt-Dijkema

This library is free software; you can redistribute it and/or modify
it under LGPL. 

=cut



