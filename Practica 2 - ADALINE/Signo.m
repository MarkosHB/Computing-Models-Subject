function Out=Signo(inp)
Out=sign(inp);
Out(Out<=0)=0;
Out(Out>0)=1;
