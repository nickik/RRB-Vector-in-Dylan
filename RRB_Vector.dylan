module: RRB_Vector
synopsis: 
author: 
copyright: 


define class <node> (<object>)
  constant slot counts :: <vector>, init-keyword: a-count:;
  constant slot vals :: <vector>, init-keyword: a-branch:; 
end class <node>;

define class <RRB-Vector>(<sequence>)
  constant slot cnt :: <integer> = 0, init-keyword: size:;
  constant slot node :: <node> = make(<node>), init-keyword: node:;
  constant slot shitf :: <integer> = 5, init-keyword: shift:;
end class <RRB-Vector>;

define method print-object ( node :: <node>, stream :: <stream> ) => ()
  format-out("%=", map( method (cnt) cnt end, node.counts));
end method print-object;

define method print-object ( vec :: <RRB-Vector>, stream) => ()
  format-out("%=\n", vec.root-node); 
end method print-object;

define function main(name, arguments)

  

  exit-application(0);
end function main;

define method size ( vec :: <RRB-Vector> ) 
  vec.cnt;
end method size;

define method complet? ( node :: <node>)
  empty?( node.counts )
end method complet?;

define method element ( vec :: <RRB-Vector>, key, #key default)
  if (key >= 0 & key < vec.cnt )
    let node = vec.node;
    //let node-vals = node.vals

    for (level from vec.shift above  0 by - 5)
      let i = logand( ash(key, level), 31)
      if ( complet?(node) )
	node := node.vals[i];
      else

	block(return) 
	  for (x in bar) if (x == "foo") return(x) end end


        if (node.counts[i] >= i)
	  while (
	  let zero-i =  i - node.counts[i];
	  if ( node.counts[i+1] >= zero-i )
	    


	  else
	    node := node.vals[i+1];
	  end if;
	  if ( (i - node.counts[i])
        else
	  node := node.vals[i]
      end if;
    end for;
    
    if ( complet?(node) )
      node.vals[logand(key, 31)];
    else
      
    end if;
  else
    default;
  end if;
end method element;

// Invoke our main() function.
main(application-name(), application-arguments());
