use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    'NAME'		=> 'Conf::INI',
    'VERSION_FROM'	=> 'lib/Conf/INI.pm',
    'PREREQ_PM'		=> { Tie::Cfg => 0.3 , Conf => 0.04 },
    'ABSTRACT_FROM'     => 'lib/Conf/INI.pm',
    'AUTHOR'            => 'Hans Oesterholt-Dijkema <oesterhol@cpan.org>',
);

