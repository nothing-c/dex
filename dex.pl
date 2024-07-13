use v5.10; use Getopt::Std; use JSON::PP;
our $F='./dex';
#our %C=(
#    flooble => {Address=>"12345 main st", Cell=>"123-456-7890"},
#    barble => {Discord=>"\@xxx_barble_xxx", Email=>"bble84\@gmx.com"}
#    );

#name, platform, value
sub add($$$) {
    my $n=shift; my $p=shift; my $v=shift; $C{$n}->{$p}=$v;
}

sub help() { say "Help thing here"; exit; }

sub details($) { my $n=shift; die "Contact $n does not exist" unless exists $C{$n}; say "Name: $n"; while (my ($k, $v) = each %{$C{$n}}) { say "$k: $v";}}

sub listc() { for (sort keys %C) { say $_; } }

sub existp($) { return True if exists $C{$_[0]}; return False; }

help unless @ARGV;

# load from file
open my $f,"<",$F; %C=%{decode_json join '',(<$f>)}; close $f;

# dump details of person; existence is checked in details()
if ($ARGV[0] !~ /-\w/) {say details $ARGV[0]; exit;}

getopts 'lhe:';
listc if $opt_l;
say existp $opt_e if $opt_e;
help if $opt_h;




