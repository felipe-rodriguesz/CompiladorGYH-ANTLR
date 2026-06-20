package com.felipe.gyh.lang.antlr;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class GyhProgram {
    private SymbolTable varTable;

    // O construtor agora recebe a tabela de símbolos populada pelo ANTLR
    public GyhProgram(SymbolTable varTable) {
        this.varTable = varTable;
    }
    
    public void generateTarget() {
        StringBuilder str = new StringBuilder();
        
        str.append("#include<stdio.h>\n");
        str.append("#include<stdlib.h>\n\n");
        str.append("void main() { \n"); 
        
        if (varTable != null) {
            for(Symbol symbol: varTable.getAll()) {
                str.append("\t").append(symbol.generateCode()).append("\n");
            }
        }
        
        str.append("}\n");
        
        try {
            try (FileWriter file = new FileWriter(new File("programaGyh.c"))) {
                file.write(str.toString());
            }
        }
        catch(IOException ex) {

        }
        
        System.out.println(str.toString()); 
    }

    public SymbolTable getVarTable() {
        return varTable;
    }

    public void setVarTable(SymbolTable varTable) {
        this.varTable = varTable;
    }
}