#!/usr/bin/perl

#use if $] < 5.008, "utf8";

use YAML::Syck qw(LoadFile Dump);

my $yml = LoadFile('DNSrecord.yml');

open D,'>','dates.csv';
open P,'>','puny.csv';
binmode(P, "encoding(UTF-8)");

foreach my $d (sort keys %$yml) {
 foreach my $sub (sort keys %{$yml->{$d}}) {
   if ($sub eq '_dates' && ref($yml->{$d}{$sub}) ne 'HASH') {
       my @nodes = split "\n",$yml->{$d}{$sub};
       foreach my $l (@nodes) {
          my ($node,$exp) = (split/[\s\t]+/,$l)[0,2];
          printf qq'$node.,contact,RP,"%s"\n',$yml->{$d}{'@'}{RP} if $yml->{$d}{'@'}{RP};
          print D qq'$node.,_dates,TXT,"$l"\n';
          print qq'$node.,_expires,TXT,"$exp"\n';
          if ($node =~ m/^xn\-\-(\w+)\.(\w+)/) {
             my $punycode = "$1";
             use Net::IDN::Punycode qw(:all);
             my $unicode  = decode_punycode($punycode);
             my $i18n = $unicode.'.'."$2";
             printf P qq'%s.,unicode,TXT,"%s"\n',$node,$i18n;
          }
       }
       printf qq'$d.,@,TXT,"counts=%d"\n',scalar@nodes;
   } elsif (ref($yml->{$d}{$sub}) ne 'HASH') {
     printf "ERROR: types' %s.%s: %s\n",$sub,$d,Dump($yml->{$d}{$sub});
     exit;
   }
   if (ref($yml->{$d}{$sub}) eq 'HASH') {
      foreach my $type (sort keys %{$yml->{$d}{$sub}}) {
         if (ref($yml->{$d}{$sub}{$type}) eq 'ARRAY') {
            foreach my $value (@{$yml->{$d}{$sub}{$type}}) {
               if ($value =~ m/\s/) {
                 printf qq'%s.,%s,%s,"%s"\n',$d,$sub,$type,$value;
               } else {
                 printf "%s.,%s,%s,%s\n",$d,$sub,$type,$value;
               }
            }
         } else { # scalar
            printf qq'%s.,%s,%s,"%s"\n',$d,$sub,$type,$yml->{$d}{$sub}{$type};
         }
      }
   }
 }
}

close D;
close P;
exit $?;
