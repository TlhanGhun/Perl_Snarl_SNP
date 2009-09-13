package SnarlNetworkProtocol;

use vars qw($VERSION); $VERSION = '1.00';
use warnings;
use strict;
use IO::Socket;
use Exporter;
use Carp;

# Derived from Rui Carmo's (http://the.taoofmac.com)
# netgrowl.php (http://the.taoofmac.com/space/Projects/netgrowl.php)
# Nathan McFarland - (http://nmcfarl.org)
# by Sven Walther (http://tlhan-ghun.de/)

# this file needs to be saved in UTF-8 in order to support special chars

our @ISA    = qw(Exporter);
our @EXPORT = ( 'register', 'addClass', 'notification', 'unregister' );my $snarlHost = "localhost";
my $snarlPort = 9887;
my $snarlAppName = "";

sub register {
    my ($self, %args) = @_;

    if($args{host}) {
      $snarlHost = $args{host};
    }
    
    if($args{port}) {
      $snarlPort = $args{port};
    }
    
    if($args{appName}) {
      $snarlAppName = $args{appName};
    }
    else
    {
      die("Parameter appName missing");
    }
        
    my %addr = (
                 PeerAddr => $snarlHost,
                 PeerPort => $snarlPort,
                 Proto    => 'tcp' );
    my $socket = IO::Socket::INET->new(%addr) || die "Could not create socket: $!\n";
    my $p = "type=SNP#?version=1.0#?action=register#?app=$snarlAppName\r\n";
    print( $socket $p );
    my $answer=<$socket>;
    close($socket);
    return $answer;
}

sub unregister {
    my ($self, %args) = @_;
    

        
    my %addr = (
                 PeerAddr => $snarlHost,
                 PeerPort => $snarlPort,
                 Proto    => 'tcp' );
    my $socket = IO::Socket::INET->new(%addr) || die "Could not create socket: $!\n";
    my $p = "type=SNP#?version=1.0#?action=unregister#?app=$snarlAppName\r\n";
    print( $socket $p );
    my $answer=<$socket>;
    close($socket);
    return $answer;
}

sub addClass {
    my ($self, %args) = @_;
    
    my $className = "";
    
    if($snarlAppName eq "") {
      die("Please register first");
    }
    
    if($args{className}) {
       $className = $args{className};
    }
    else
    {
      die("Parameter className missing");
    }    
        
    my %addr = (
                 PeerAddr => $snarlHost,
                 PeerPort => $snarlPort,
                 Proto    => 'tcp' );
    my $socket = IO::Socket::INET->new(%addr) || die "Could not create socket: $!\n";
    my $p = "type=SNP#?version=1.0#?action=add_class#?app=$snarlAppName#?class=$className#?title=$className\r\n";
    print( $socket $p );
    my $answer=<$socket>;
    close($socket);
    return $answer;
}

sub notification {
    my ($self, %args) = @_;
    
    my $className = "";
    my $title = "";
    my $text = "";
    my $timeout = 10;
    my $icon = "";

    if($args{class}) {
       $className = $args{class};
    }
    else
    {
      die("Parameter class missing");
    } 

    if($args{title}) {
       $title = $args{title};
    }
    else
    {
      die("Parameter title missing");
    } 
    
    if($args{text}) {
       $text = $args{text};
    }
    else
    {
      die("Parameter text missing");
    }     
    
    if($args{timeout}) {
       $timeout = $args{timeout};
    }
    else
    {
      die("Parameter timeout missing");
    } 

    if($args{icon}) {
       $icon = '#?icon='.$args{icon};
    }
        
    my %addr = (
                 PeerAddr => $snarlHost,
                 PeerPort => $snarlPort,
                 Proto    => 'tcp' );
    my $socket = IO::Socket::INET->new(%addr) || die "Could not create socket: $!\n";
    
    
    my $p = "type=SNP#?version=1.0#?action=notification#?app=$snarlAppName#?class=$className#?title=$title#?text=$text#?timeout=$timeout$icon\r\n";
    print( $socket $p );
    my $answer=<$socket>;
    close($socket);
    return $answer;
}



sub new {
        my $class = shift;
        my $self = {};
        bless $self, $class;
        return $self;
}


1;