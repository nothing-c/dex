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

sub listps($) { my $n=shift; die "Contact $n does not exist" unless exists $C{$n}; for (sort keys %{$C{$n}}) { say; } }

sub main() {
    getopts 'lhe:u:p:v:a:d:o:';
    listc if $opt_l;
    listps $opt_o if $opt_o; #need to impl
    say existp $opt_e if $opt_e;
    if ($opt_a) { return "Need platform(s) and value(s) to add user!\n" unless ($opt_a && $opt_p && $opt_v); add $opt_a, $opt_p, $opt_v; } # I think this should work, but I need to test
    if ($opt_u) { return "Platform(s) and value(s) to update user!\n" unless ($opt_u && $opt_p && $opt_v); } #need update function
    if ($opt_d) { return delete $C{$opt_d} unless $opt_p; delete $C{$opt_d}->{$opt_p}; } # should work
    help if $opt_h;
    return '';
}

help unless @ARGV;

# load from file
open my $f,"<",$F; %C=%{decode_json join '',(<$f>)}; close $f;

# dump details of person; existence is checked in details()
if ($ARGV[0] !~ /-\w/) {say details $ARGV[0]; exit;}

print main;

# dump to file
open my $f,">",$F; print $f encode_json \%C; close $f;



