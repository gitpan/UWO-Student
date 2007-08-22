#!perl

# $Id: Makefile.PL 2 2007-08-22 20:29:23Z frequency $

use strict;
use warnings;

use ExtUtils::MakeMaker ();

use File::Spec;

my @tests = glob File::Spec->catfile('t', '*.t');

ExtUtils::MakeMaker::WriteMakefile(
  NAME                => 'UWO::Student',
  AUTHOR              => 'Jonathan Yu <frequency@cpan.org>',
  VERSION_FROM        => 'lib/UWO/Student.pm',
  ABSTRACT_FROM       => 'lib/UWO/Student.pm',
  PL_FILES            => {},
  PREREQ_PM => {
    # Pragmatic and special modules
    'overload'        => 0,
    'Carp'            => 1.04,

    # Other modules
    'Test::More'      => 0.70,
  },

  test                => { TESTS => join(' ', @tests) },
  dist                => {
    COMPRESS          => 'gzip -9f',
    SUFFIX            => 'gz',
  },
  clean               => { FILES => 'UWO-Student-*' },
);
