use v5.10; use Getopt::Std; use JSON::PP;
our $V="1.0";
our $F='~/.dex';
our %C; # contacts

#name, platform, value
sub add($$$) {
    my $n=shift; my $p=shift; my $v=shift; $C{$n}->{$p}=$v;
}

sub details($) { my $n=shift; die "Contact $n does not exist" unless exists $C{$n}; say "Name: $n"; while (my ($k, $v) = each %{$C{$n}}) { say "$k: $v";}}

sub listc() { for (sort keys %C) { say $_; } }

sub existp($) { return True if exists $C{$_[0]}; return False; }

sub listps($) { my $n=shift; die "Contact $n does not exist" unless exists $C{$n}; for (sort keys %{$C{$n}}) { say; } }

sub help() {
    say "dex v$V";
    say "dex is a command-line rolodex";
    say "Usage: dex [contact | -lh | -e contact | -o contact | -a contact -p platform -v value | -d contact [-p platform]]";
    say "Options:";
    say "  -a add or update a contact";
    say "  -d delete a contact (or delete a platform from a contact with the -p switch)";
    say "  -e check if contact exists";
    say "  -h show this message";
    say "  -l list all contacts";
    say "  -o list platforms the contact is on";
    say "  -p what platform the contact is on";
    say "  -v the value for a given platform (email address, phone number, etc.)";
    exit; }

sub main() {
    getopts 'lhe:p:v:a:d:o:';
    listc if $opt_l;
    listps $opt_o if $opt_o; #need to impl
    say existp $opt_e if $opt_e;
    if ($opt_a) { return "Need platform(s) and value(s) to add user!\n" unless ($opt_a && $opt_p && $opt_v); add $opt_a, $opt_p, $opt_v; }
    if ($opt_d) { return delete $C{$opt_d} unless $opt_p; delete $C{$opt_d}->{$opt_p}; }
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



