#initialize some vars
sep+++++ +++++ # separator
>len[-]
>l[-]
# read random sead from stdin
>>>>>>>randomh, 
>randoml,
>x[-]
>temp6[-]
>temp7[-]

# read names from stdin
>>>>>>DATA>++++++++++>,
[
	>,+
	[<]DATA<<<temp8[-]
	>temp9[-]
	>>DATA>[>]<x-
	[ # if not EOF move x to temp8 and copy to temp9
		[<]DATA<<<temp8+>temp9+>>DATA>[>]<x-
	]+[<]DATA<<<temp8
	[ # if temp8 move temp8 to x
		>>>DATA>[>]<x+[<]DATA<<<temp8-
	]>temp9>>>DATA>[>]<x<[<]DATA<<temp9
	[ # if not EOF
		>>DATA>[>]<x
		[->+>+<<]>[-<+>] # copy x 2 cells to the right
		>-< # correct for flag
		# copy sep 1 cell to the right of x
		+<x[<]DATA <<<<< <<<<< <<<<< <<<< sep
		[ 
			->>>>> >>>>> >>>>> >temp8+>>>DATA>[>]<<+[<]DATA<<<<< <<<<< <<<<< <<<<sep
		]>>>>> >>>>> >>>>> >temp8[-<<<<< <<<<< <<<<< <sep+>>>>> >>>>> >>>>> >temp8]
		>>>DATA>[>]<<-
		# if x==sep 
			[->-<]+>[<->[-]]<
			[ # then count names
				-<[<]DATA<<<<< <<<<< <<<<< <<<len+>>>>> >>>>> >>>>> >>>DATA>[>]
			]
		<x[<]DATA<<temp9[-]
	]
	>>DATA>[>]<x-
]

# check if list ends with a sep, if not increment counter and add a sep
<x[->>+>+<<<]>>[-<<+>>] # copy x 3 cells to the right
# copy sep 2 and 4 cells to the right of last data entry (x)
<<x[<]DATA <<<<< <<<<< <<<<< <<<< sep
[ 
	->>>>> >>>>> >>>>> >temp8+>>>DATA>[>]>+>>+<<<<[<]DATA<<<<< <<<<< <<<<< <<<<sep
]>>>>> >>>>> >>>>> >temp8[-<<<<< <<<<< <<<<< <sep+>>>>> >>>>> >>>>> >temp8]
>>>DATA>[>]>
# if x!=sep 
[->-<]+>[<->[-]]<
-[
	<<[<]DATA<<<<< <<<<< <<<<< <<<len+
	>>>>> >>>>> >>>>> >>>DATA>[>]
	# move the remaining sep to the right position at the end of the list
	>>>[-<<<+>>>]
	<[-]<[-]<[-]
]
>[-]>[-]>[-]<<<<

# print number of participants
MSG++++[++++>---<]>.+[-->+++<]>++.+++++++..++++.----------.+++++.-------.-[--->+<]>--.--[->++++<]>-.+[->+++<]>+.++++++++++.++++[->+++<]>.+++++++.-[--->+<]>.-[---->+<]>++.[->+++<]>+.++++++++++++.++.-.-------.-[--->+<]>--.[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]

# copy len to an empty cell for printing
<[<]DATA<<<<< <<<<< <<<<< <<<len
[->>>>> >>>>> >>>>> >>>DATA>[>]>+>+<<<<[<]DATA<<<<< <<<<< <<<<< <<<]
>>>>> >>>>> >>>>> >>>DATA>[>]>>[-<<<[<]DATA<<<<< <<<<< <<<<< <<<len+>>>>> >>>>> >>>>> >>>DATA>[>]>>]<tmp

>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-
<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++
<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<
#clean up
[-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]>[-]<<<<<<<<<<

MSG++++[->++++++++<]>.[->+++<]>++.[--->+<]>----.+++[->+++<]>++.+[--->+<]>.+[->+++<]>.--[--->+<]>-.++[->++<]>.[--->+<]>+++.--.-[->+++<]>-.+[--->+<]>+++.-----------.+.+++++++++++++.+.+[++>---<]>...>++++++++++.[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<

# decrement len by one
<[<]DATA<<<<< <<<<< <<<<< <<<len-

# generate a pseudo random number (taken from http://esolangs DOT org)
>l+
[
	>temp0[-]
	>temp1[-]
	>temp2[-]
	>temp3[-]
	>temp4[-]
	>temp5[-]
	>randomh[<<<<<<+>>>>>>-]
	>randoml[<<<<<<+>>>>>>-]
	<<<<temp3+++++++[<temp2+++++++++++@>temp3-]
	<temp2[
	 <<temp0[>>>>>>randomh+<<<temp3+<<<temp0-]
	 >>>temp3[<<<temp0+>>>temp3-]
	 <<temp1[>>>>>randomh+<<<temp3+>temp4+<<<temp1-]
	 >>>temp4[<<<temp1+>>>temp4-]
	 <temp3[
	  >>>>randoml+[<<<temp4+>temp5+>>randoml-]
	  <<temp5[>>randoml+<<temp5-]+
	  <temp4[>temp5-<temp4[-]]
	  >temp5[>randomh+<temp5-]
	 <<temp3-]
	<temp2-]
	++++++[>temp3++++++++<temp2-]
	>temp3-[
	 <<temp1[>>>>>randomh+<<<<temp2+<temp1-]
	 >temp2[<temp1+>temp2-]
	>temp3-]
	<<<temp0[-]>temp1[-]+++++[<temp0+++++>temp1-]
	<temp0[
	 >>>>>>>randoml+[<<<<<<temp1+>temp2+>>>>>randoml-]
	 <<<<<temp2[>>>>>randoml+<<<<<temp2-]+
	 <temp1[>temp2-<temp1[-]]
	 >temp2[>>>>randomh+<<<<temp2-]
	<<temp0-]
	++++++[>>>>>>randomh+++++++++<<<<<<temp0-]
	>>>>>>randomh[>>x+<<<<<<<<temp0+>>>>>>randomh-]
	<<<<<<temp0[>>>>>>randomh+<<<<<<temp0-]


	reject random number if not in range
	<l[-]
	>>>>>>>>>x

	[->+>+<<]>[-<+>]>[-<<x<<<<<<<<<+>>>>>>>>>x>>]<< copy x to l

	<<<<<<<<
	temp0[-]
	>temp1[-] >[-]+ >[-] <<
	<<<max[>>temp0+ >temp1+ <<<max-]
	>>>temp1[<<<max+ >>>temp1-]
	<<l[>>temp1+ <<l-]
	>>temp1[>-]> [< <<l+ >temp0[-] >temp1>->]<+<
	<temp0[>temp1- [>-]> [< <<l+ >temp0[-]+ >temp1>->]<+< <temp0-]
	<-
]

>>>>>>>>>rand

# print message
>>>>> >>>DATA>[>]
MSG-[------->+<]>---.+[--->+<]>++.+++.++.+.-------.---------.--[--->+<]>-.-[--->++<]>-.++++++++++.+[---->+<]>+++.-[--->++<]>+.--.+++++.----------.-[--->+<]>-.---[->++++<]>.-----.[--->+<]>-----.--[->++++<]>+.----------.++++++.-[++>---<]>--.------------.[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<[-]<
<[<]DATA<<<<<<<<rand


# look up the winner (the last will be the first)

<[-]> # clear randoml not needed anymore

>>>>> >>>DATA>[>]<<
[
	[->>+>+<<<]>>[-<<+>>] # copy x 3 cells to the right
	# copy sep 2 cells to the right of x
	<<x[<]DATA <<<<< <<<<< <<<<< <<<< sep
	[ 
		->>>>> >>>>> >>>>> >temp8+>>>DATA>[>]>+<<[<]DATA<<<<< <<<<< <<<<< <<<<sep
	]>>>>> >>>>> >>>>> >temp8[-<<<<< <<<<< <<<<< <sep+>>>>> >>>>> >>>>> >temp8]
	>>>DATA>[>]>
	# if x==sep 
	[->-<]+>[<->[-]]<
	[ # then decrement counter
		-<<[<]DATA<<<<< <<<rand->>>>> >>>DATA>[>]>
	]
	# delete x if counter is non zero
	<<[<]DATA<<<<< <<<rand
	[
		>>>>> >>>DATA>[>]<x
		[-]
		>>>[-]
		<<<
	]
	<
]
>>>>> >>>>DATA>[>]<[-]<
[
	[->>+>+<<<]>>[-<<+>>] # copy x 3 cells to the right
	# copy sep 2 cells to the right of x
	<<x[<]DATA <<<<< <<<<< <<<<< <<<< sep
	[ 
		->>>>> >>>>> >>>>> >temp8+>>>DATA>[>]>+<<[<]DATA<<<<< <<<<< <<<<< <<<<sep
	]>>>>> >>>>> >>>>> >temp8[-<<<<< <<<<< <<<<< <sep+>>>>> >>>>> >>>>> >temp8]
	>>>DATA>[>]>
	# if x==sep 
		[->-<]+>[<->[-]]<
		[ # then print name
			>>[>]<[<]
			>[.>]>>>>
		]
		[-]>[-]<<<
	[->>>+<<<]<
]

++++[->++++++++<]>+.[-]+++++ +++++.




