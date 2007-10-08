#!perl -T

# $Id: 03email-handle.t 10 2007-10-02 02:17:34Z frequency $

use strict;
use warnings;

use Test::More;

use UWO::Student;

# We can only test this if Email::Handle is installed
eval 'use Email::Handle 0.01';

if ($@) {
  plan skip_all => 'Email::Handle not installed';
}

plan tests => 6;

my $eh = Email::Handle->new('jdoe@uwo.ca');
isa_ok($eh, 'Email::Handle');

my $stu = UWO::Student->new;
isa_ok($stu, 'UWO::Student');

$stu->email('jdoe@uwo.ca');
is($stu->email->as_string, 'jdoe@uwo.ca', 'Stringification');
is($stu->email,            'jdoe@uwo.ca', 'Overloaded stringification');
is($stu->email->user,      'jdoe',        'Extract username');
is($stu->email->host,      'uwo.ca',      'Extract host');
