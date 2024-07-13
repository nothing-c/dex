use v5.10; use Getopt::Std;
our %C=(
    flooble => {Address=>"12345 main st", Cell=>"123-456-7890"},
    barble => {Discord=>"\@xxx_barble_xxx", Email=>"bble84\@gmx.com"}
    );

# $C{contact-name}={Address=>"12345 main st", Cell=>"123-456-7890"}; and so on

#name, platform, value
sub add($$$) {
    my $n=shift; my $p=shift; my $v=shift; $C{$n}->{$p}=$v;
}

sub help() { say "Help thing here"; exit; }

sub details($) { my $n=shift; die "Contact $n does not exist" unless exists $C{$n}; say $n; while (my ($k, $v) = each %{$C{$n}}) { say "$k: $v";}}

help unless @ARGV;

# load from file

# dump details of person; existence is checked in details()
if ($ARGV[0] !~ /-\w/) {say details $ARGV[0]; exit;}

getopts 'h';
help if $opt_h;




