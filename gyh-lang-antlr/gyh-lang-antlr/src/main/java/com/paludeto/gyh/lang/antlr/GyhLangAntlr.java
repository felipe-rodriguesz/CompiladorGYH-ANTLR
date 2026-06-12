/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.paludeto.gyh.lang.antlr;

import gyhlangantlr.GyhGrammarLexer;
import gyhlangantlr.GyhGrammarParser;
import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.ParseTree;

/**
 *
    * @author a2572044
 */

public class GyhLangAntlr {

    public static void main(String[] args) throws IOException {

        CharStream input = CharStreams.fromFileName("programa0.gyh");
        GyhGrammarLexer lexer = new GyhGrammarLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        GyhGrammarParser parser = new GyhGrammarParser(tokens);
        
        // === ANÁLISE LÉXICA ===
        System.out.println("=== ANÁLISE LÉXICA ===\n");
        tokens.fill();
        
        int i = 0;
        Token token;
        while ((token = tokens.get(i)).getType() != Token.EOF) {
            System.out.println("Token " + i + ": " + token.getText() + 
                             " | Type: " + token.getType() + 
                             " | Line: " + token.getLine() + 
                             " | Column: " + token.getCharPositionInLine());
            i++;
        }
        
        // === ANÁLISE SINTÁTICA ===
        System.out.println("\n=== ANALISE SINTATICA ===\n");
        
        // Recriar porque os tokens já foram consumidos
        CharStream input2 = CharStreams.fromFileName("programa0.gyh");
        GyhGrammarLexer lexer2 = new GyhGrammarLexer(input2);
        CommonTokenStream tokens2 = new CommonTokenStream(lexer2);
        GyhGrammarParser parser2 = new GyhGrammarParser(tokens2);
        
        // Fazer parse da regra raiz
        ParseTree tree = parser2.programa();
        
        // Exibir a árvore sintática
        System.out.println("Arvore sintatica:");
        System.out.println(tree.toStringTree(parser2));
    }
}