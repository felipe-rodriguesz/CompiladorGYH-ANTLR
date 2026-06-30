/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 *
 * Compilador GYH - ANTLR
 * Dupla: Felipe Dos Santos Rodrigues e Guilherme Giuliangeli Monteiro
 * Link do Vídeo da Apresentação: https://drive.google.com/file/d/1EkN1ZYnie4fF92zSBrZqWd0yB3En4AMU/view?usp=sharing
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

        CharStream cs = CharStreams.fromFileName("programa2.gyh");
        GyhGrammarLexer lexer = new GyhGrammarLexer(cs);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        GyhGrammarParser parser = new GyhGrammarParser(tokens);
        parser.programa();
    }
}