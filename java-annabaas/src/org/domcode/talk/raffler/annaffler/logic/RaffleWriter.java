/*
              _,;;.,_
     ,-;;,_  ;,',,,'''@
  ,;;``  `'\\|//``-:;,.
@`         ;^^^;      `'@
           :@ @:
           \ u /
  ,=,------)^^^(------,=,
  '-'-----/=====\-----'-'
          \_____/
      '`\ /_____\
      `\ \\_____/_
        \//_____\/|
        |        ||
        |  ldb   |'
        :________:`
 */
package org.domcode.talk.raffler.annaffler.logic;

import org.domcode.talk.raffler.annaffler.util.IWriter;

public class RaffleWriter implements IWriter {

	@Override
	public void write(String stringToWrite) {
		System.out.println(stringToWrite);
	}

	@Override
	public void hookFunctionOne() {
//		“I feel as if I were a piece in a game of chess,
//		when my opponent says of it: 
//		That piece cannot be moved.” 
//		― Søren Kierkegaard

	}

	@Override
	public void hookFunctionTwo() {
//		'What's so negative about it?' I said.
//		'What could be a more negative word than "futility"?' he said.
//		'"Ignorance,"' I said.” 
//		― Kurt Vonnegut, Hocus Pocus
	}

	@Override
	public void hookFunctionThree() {
//		“The difficulty in dealing with a maze or labyrinth 
//		lies not so much in navigating the convolutions to find the exit, 
//		but in not entering the damn thing in the first place.
//		― Vera Nazarian
	}

}
