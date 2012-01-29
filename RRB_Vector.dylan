module: RRB_Vector
synopsis: 
author: 
copyright: 


define constant branch-factor = 4;

define class <node> (<object>)
  constant slot counts :: <vector> = make(<vector>), init-keyword: a-count:;
  constant slot vals :: <vector>, init-keyword: a-branch:; 
end class <node>;

define class <RRB-Vector>(<sequence>)
  constant slot cnt :: <integer> = 0, init-keyword: size:;
  constant slot node :: <node> = make(<node>), init-keyword: node:;
  constant slot level :: <integer> = 1, init-keyword: level:;
end class <RRB-Vector>;

define method print-object ( node :: <node>, stream :: <stream> ) => ()
  format-out("%=", node.vals);
end method print-object;

define method print-object ( vec :: <RRB-Vector>, stream :: <stream> ) => ()
  format-out("%=", vec.node); 
end method print-object;

define function main(name, arguments)

let key = 3;
let mynode = make(<node>, 
		a-branch: vector(make(<node>, a-branch: #[0, 1, 2], a-count: #[1, 2, 3]),
				 make(<node>, a-branch: #[3, 4, 5, 6], a-count: #[1, 2, 3, 4]), 
				 make(<node>, a-branch: #[7, 8, 9, 10], a-count: #[1, 2, 3, 4])),
		a-count: #[3, 7, 11]);

let myvec  = make(<RRB-Vector>, 
		  node: mynode,
		  size: 11,
		  level: 1);

format-out("%=\n", map( method (x) element(myvec, x) end, #[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));

  exit-application(0);
end function main;

define method size ( vec :: <RRB-Vector> ) 
  vec.cnt;
end method size;

define function myprint (name, val)
  format-out("%=: %=\n", name, val);
end function myprint;

define method element ( vec :: <RRB-Vector>, key :: <integer>, #key default) => (obj :: <object>)
  if ( key >= 0 & key < vec.cnt )
    block(element-return)
      let node :: <node> = vec.node;
      for (level from vec.level to 0 by - 1)
	let index = floor/( key, branch-factor ^ level );
	if ( level > 0 )
	  node := block(return)
		    for ( i from index below size( node.vals ))
		      let barrier = node.counts[i];
		      if ( key < barrier )
			if ( i > 0 )
			  key := key - node.counts[i - 1];
			end if;
			return(node.vals[i]);
		      end if;
		    end for;
		  end block;
	else
	  element-return( node.vals[index] );
	end if;
      end for;
    end block;
  else
    default;
  end if;
end method element;



define class <node> (<object>)
  constant slot counts :: <vector> = make(<vector>), init-keyword: a-count:;
  constant slot vals :: <vector>, init-keyword: a-branch:; 
end class <node>;

define class <RRB-Vector>(<sequence>)
  constant slot cnt :: <integer> = 0, init-keyword: size:;
  constant slot node :: <node> = make(<node>), init-keyword: node:;
  constant slot level :: <integer> = 1, init-keyword: level:;
end class <RRB-Vector>;


define method add ( vec :: <PRB-Vector>, val ) => (result-vec :: <PVector>)
  
  let node :: <node> = vec.node;   

  for ( level from vec.level to 0 by - 1)
        
    
    let newnode :: <node> = make(<node>, 
				 a-count: node.counts, 
				 a-branch: node.vals);
    
    last( newnode.counts ) := last( newnode.counts ) + 1;
    last( newnode.vals )   := last (   ) 

  end for;


  make(<RRB-Vector>,
       size: vec.cnt + 1,
       level: vec.level,
       node: newnode);
       
   
end method add;

// Invoke our main() function.
main(application-name(), application-arguments());