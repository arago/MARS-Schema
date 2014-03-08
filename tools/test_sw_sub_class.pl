#!/usr/bin/perl -w
#
# little helper tool to check new combination of 
# SW class/subclass
# 
use strict;
use Getopt::Long qw(:config no_ignore_case);

my ($class, $subclass, $schema_file);
my $show_help = 0;

# $tool_path could be used to not rely on PATH to find xmllint
my $tool_path;

my $result = GetOptions ("help!" => \$show_help,
			 "c|class=s" => \$class,
			 "s|subclass=s" => \$subclass,
			 "S|schema=s" => \$schema_file,
    );
usage() unless ($result);
usage() if ($show_help);
usage() unless ($class);
usage() unless ($subclass);
unless($schema_file) {
    print STDERR "WARNING: no schema file specified. Only well-formedness will be cecked\n\n";
}


my $xml_text = << "EOF";
<$subclass xmlns="http://mars-o-matic.com"
	ID="Test:UnitTests:Software:software1"
	SoftwareClass="$class"
	SoftwareSubClass="$subclass"
	NodeType="Software"
	NodeName="software1"
	>
  <CustomerInformation ID="customer1" />
</$subclass>
EOF

my $cmd = 'xmllint';
$cmd = $tool_path.'/'.$cmd if ($tool_path);
$cmd .= ' --schema '.$schema_file if ($schema_file);

my $tmp_file = '/tmp/'.$0.'.'.$$;
$cmd .= ' '.$tmp_file;
if(open(TMP, ">", $tmp_file)) {
    print TMP $xml_text;
    close(TMP);
    
    system($cmd);
} else {
    # complain
}

# --------------------------------------------------------------------- #
# usage
# --------------------------------------------------------------------- #
sub usage {

    print <<"EOF";

Usage:

$0 -c <class> -s <subclass> [-s <schemafile>]

More options:

  --class=<class>         same as -c <class>
  --subclass=<subclass>   same as -s <subclass>
  --schema=<schemafile>   same as -S <schemafile>
  --help                  show this help
EOF

exit 0;
}

