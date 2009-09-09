require "SnarlNetworkProtocol.pm";
use SnarlNetworkProtocol;

  my $snarlClient = new SnarlNetworkProtocol;

  print $snarlClient->register(host => 'localhost',port => '9887',appName => 'Example Perl App') or die ("Error: $!\n"); 
    
  print $snarlClient->addClass(className=>"First Class") or die ("Error: $!\n");
  print $snarlClient->addClass(className=>"Second Class") or die ("Error: $!\n"); 
  
  print $snarlClient->notification(class=>"First Class",title=>"My first title",text=>"And some text", timeout=>10,icon=>"http://www.google.de/images/nav_logo6.png");
  print $snarlClient->notification(class=>"Second Class",title=>"My second title",text=>"And some text", timeout=>10);
  
  print "\nPlease press return to unregister";
  $line = <STDIN>;
    print $snarlClient->unregister();