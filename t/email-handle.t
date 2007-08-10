#!perl -T

use Test::More tests => 6;

use UWO::Student;

# Only bother testing if Email::Handle is actually installed
SKIP: {
  eval { require Email::Handle; };

  skip('Email::Handle not installed', 6) if $@;

  my $eh = Email::Handle->new('jdoe@uwo.ca');
  isa_ok($eh, 'Email::Handle');

  my $stu = UWO::Student->new;
  isa_ok($stu, 'UWO::Student');

  $stu->email('jdoe@uwo.ca');
  is($stu->email->as_string, 'jdoe@uwo.ca', 'Stringification');
  is($stu->email,            'jdoe@uwo.ca', 'Overloaded stringification');
  is($stu->email->user,      'jdoe',        'Extract username');
  is($stu->email->host,      'uwo.ca',      'Extract host');
}
