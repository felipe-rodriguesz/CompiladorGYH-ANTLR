/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.felipe.gyh.lang.antlr;

import gyhlangantlr.GyhGrammarLexer;
import gyhlangantlr.GyhGrammarParser;
import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
/*import org.antlr.v4.runtime.Token;*/

public class GyhLangAntlr {
    public static void main(String[] args) throws IOException {

        CharStream cs = CharStreams.fromFileName("programa6.gyh");
        GyhGrammarLexer lexer = new GyhGrammarLexer(cs);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        GyhGrammarParser parser = new GyhGrammarParser(tokens);
        parser.programa();
    }
}