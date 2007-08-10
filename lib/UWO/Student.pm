# UWO::Student
#  Represent a student as an object
#
# Copyright (C) 2006-2007 by Jonathan Yu <frequency@cpan.org>
#
# Redistribution  and use in source/binary forms, with or without  modification,
# are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions  in binary form must  reproduce the above copyright notice,
#    this list of  conditions and the  following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# This software is  provided by the copyright  holders and contributors  "AS IS"
# and ANY  EXPRESS  OR IMPLIED  WARRANTIES, including, but  not limited  to, the
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED.
#
# In  no event  shall  the copyright  owner  or  contributors  be liable for any
# direct,  indirect,  incidental,  special,  exemplary or  consequential damages
# (including, but  not limited to, procurement of  substitute goods or services;
# loss of use, data or profits;  or business interruption) however caused and on
# any  theory of  liability,  whether in  contract,  strict  liability  or  tort
# (including  negligence or otherwise) arising in any way out of the use of this
# software, even if advised of the possibility of such damage.

package UWO::Student;

use strict;
use warnings;
use Carp ();

use overload (
  '""'       => \&as_string,
  '0+'       => \&number,
  fallback   => 1
);

# Use Email::Handle if available
eval { require Email::Handle; };

our $VERSION = '0.01';

=head1 NAME

UWO::Student - Provides Perl object representation of a University of Western
Ontario student.

=head1 SYNOPSIS

This module provides a Perl object interface representing students of the
University of Western Ontario. It performs basic input validation on given data
and will throw an exception for suspicious information.

Additional validation is recommended since, at present, the module does not
perform "deep" verification -- it does not use regular expressions and cannot
"untaint" data, if you are running Perl under taintmode (Perl flag -T).

You will probably not need to use this module directly, but its accessors may
be useful since collections of these objects are returned from the C<UWO::*>
class of modules.

Example code:

    use UWO::Student;

    # Create Perl interface to a student record
    my $stu = UWO::Student->new({
      given_name => 'John',
      last_name  => 'Doe',
    });

=head1 COMPATIBILITY

Though this module was only tested under Perl 5.8.8 on Linux, it should
be compatible with any version of Perl that supports Email::Handle and Carp.
If you encounter any problems on a different version or architecture, please
contact the maintainer.

=head1 METHODS

=head2 new(\%params)

Creates a C<UWO::Student> object, which either stores given parameters or throws
an exception if it fails the simplistic validation rules. (See the C<email> and
C<number> methods for further details.)

The parameters available are:

    my $stu = UWO::Student->new({
      given_name  => 'John',
      last_name   => 'Doe',
      faculty     => 'Faculty of Arts and Humanities',
      email       => 'jdoe@uwo.ca',
      number      => 327323372,
    });

Which instantiates a C<UWO::Student> instance representing the data as Perl
datastructures.

=cut

sub new {
  my ($class, $parm) = @_;

  # Unvalidated attribute section
  my $self = {
    given_name   => $parm->{given_name} || '',
    last_name    => $parm->{last_name} || '',
    faculty      => $parm->{faculty} || '',
    email        => '',
    number       => 0,
  };

  bless($self, $class);

  # Validated attribute section
  $self->email($parm->{email}) if defined($parm->{email});
  $self->number($parm->{number}) if defined($parm->{number});

  return $self;
}

=head2 email([$address])

Without parameters, this method returns an C<Email::Handle> object (if
available.) Otherwise, it returns a SCALAR containing the e-mail address
associated with the current C<UWO::Student> object. If you wish to force the
module to always return an C<Email::Handle> object, make sure to add
C<use Email::Handle> to your code.

Example code:

    # Retrieve the e-mail (as a SCALAR). This works even while Email::Handle is
    # in use since the stringify operation is overloaded by that module.
    print $stu->email;

    # Retrieve the e-mail username (requires Email::Handle)
    print $stu->email->user;

If C<$address> is provided, it will store the given parameter as the Student's
e-mail address.

Example code:

    # Set the student's e-mail address
    $stu->email('jdoe@uwo.ca');

This method is not guaranteed to return results. The e-mail address could very
well be C<undef> if none has been specified yet and it is not guaranteed to even
"look" valid by any account. It does parsing, but not validation.

=cut

sub email {
  my ($self, $addr) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  if (defined($addr)) {
    # Check if Email::Handle is loaded
    if (exists($INC{'Email/Handle.pm'})) {
      my $eh = Email::Handle->new($addr);
      $self->{email} = $eh;
    }
    else {
      $self->{email} = $addr;
    }
  }

  return $self->{email};
}

=head2 number([$number])

If C<$number> is given, it will store the given integer as the Student's unique
university identification number. Student numbers MUST consist of numbers 0
through 9 (of length 1-9 digits). Since this is just a SCALAR, you may also pass
an underscore-delimited integer if you wish to improve readability:

Example code:

    # Set the student's unique identification number
    $stu->number(327_323_372);
    # Is equivalent to
    $stu->number(327323372);

Without parameters, this method simply returns the stored student number (or
C<undef> if it is unavailable).

Example code:

    # Retrieve the student number
    print $stu->number;

This method is not guaranteed to return results. The student number could be
C<undef> if none has been specified yet.

=cut

sub number {
  my ($self, $number) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  if (defined($number)) {
    Carp::croak('Invalid student number') unless $number =~ /^\d{1,9}$/;

    $self->{number} = $number;
  }

  return $self->{number};
}

=head2 name()

This method intelligently concatenates the given and last names of the student.

Example code:

    # Retrieve the student's full name
    print $stu->name;

This method is not guaranteed to return results. The name may be null.

=cut

sub name {
  my ($self) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  my $name = $self->{given_name};

  # If given_name is empty, quit early
  return '' if (length($name) == 0);

  if ($self->{last_name}) {
    $name .= ' ' . $self->{last_name};
  }

  return $name;
}

=head2 given_name([$name])
=head2 last_name([$name])
=head2 faculty([$name])

These mutator methods simply set the appropriate fields if parameters are
provided. Currently, it does not perform any input validation at all, although
this behaviour may change in the future. Namely, the module may begin to
validate faculty names (as they appear in the database), since they are of a
limited size and do not change frequently.

Example code:

    # Change the student's given name
    print $stu->given_name('Joe');

    # Retrieve the student's last name
    print $stu->last_name('Blow');

    # Retrieve the faculty the student is registered in
    print $stu->faculty('Faculty of Social Science');

Without parameters, these methods act as accessors and simply return SCALARs
containing the data.

Example code:

    # Retrieve the student's given name
    print $stu->given_name;

    # Retrieve the student's last name
    print $stu->last_name;

    # Retrieve the faculty the student is registered in
    print $stu->faculty;

These methods are not guaranteed to return results. While given and last names
are always defined, the faculty name can be C<undef>. Given and last names may
be empty and defined, so check for a true value and not just C<defined>.

=cut

sub given_name {
  my ($self, $name) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  $self->{given_name} = $name if defined($name);

  return $self->{given_name};
}

sub last_name {
  my ($self, $name) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  $self->{last_name} = $name if defined($name);

  return $self->{last_name};
}

sub faculty {
  my ($self, $faculty) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  $self->{faculty} = $faculty if defined($faculty);

  return $self->{faculty};
}

=head2 as_string()

This method, which is also executed upon stringification, intelligently
composes a string representation of the given user for display. Namely, it
provides a first and last name with e-mail address, as:

    John Doe <jdoe@uwo.ca>

or, when an e-mail address is unavailable:

    John Doe

or, when we only have a first name:

    John

or, a first name and e-mail address:

    John <jdoe@uwo.ca>

or, when neither are available:

    <unknown>

Example code:

    # Stringify the student information
    print $stu->as_string;

    # Or the overloaded version
    print $stu;

This method will always return a non-null string result, however, it may not
be particularly useful. Your mileage may vary.

=cut

sub as_string {
  my ($self) = @_;

  Carp::croak('You must call this method as an object') unless ref($self);

  my $name = $self->name;

  if ($self->email) {
    $name .= ' ' unless (length($name) == 0);
    $name .= '<' . $self->email . '>' if $self->email;
  }
  
  return $name unless (length($name) == 0);

  # We don't have enough information or something dubious happened
  return '<unknown>';
}

=head1 CONTRIBUTORS

=head2 MAINTAINER

Jonathan Yu E<lt>frequency@cpan.orgE<gt>

=head1 FEEDBACK

Please send relevant comments, bug reports, rotten tomatoes and suggestions
directly to the maintainer noted above.

=head1 BUGS

There are no known bugs as of this release. Please send any bug reports to the
maintainer directly via e-mail.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Jonathan Yu E<lt>frequency@cpan.orgE<gt>

Redistribution and use in source/binary forms, with or without modification,
are permitted provided that the following conditions are met:

=over

=item 1

Redistributions of source code must retain the above copyright notice, this list
of conditions and the following disclaimer.

=item 2

Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

=back

=head1 DISCLAIMER OF WARRANTY

This software is provided by the copyright holders and contributors "AS IS" and
ANY EXPRESS OR IMPLIED WARRANTIES, including, but not limited to, the IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.

In no event shall the copyright owner or contributors be liable for any direct,
indirect, incidental, special, exemplary or consequential damages (including,
but not limited to, procurement of substitute goods or services; loss of use,
data or profits; or business interruption) however caused and on any theory of
liability, whether in contract, strict liability or tort (including negligence
or otherwise) arising in any way out of the use of this software, even if
advised of the possibility of such damage.

=cut

1;
