package com.felipe.gyh.lang.antlr;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class GyhProgram {
    private SymbolTable varTable;
    private ArrayList<Command> command;

    public GyhProgram(SymbolTable varTable, ArrayList<Command> command) {
        this.varTable = varTable;
        this.command = command;
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
        
        str.append("\n");
        
        if (command != null) {
            for(Command cmd: command) {
                str.append("\t").append(cmd.generateCode()).append("\n");
            }
        }
        
        str.append("}\n");
        
        try {
            try (FileWriter file = new FileWriter(new File("programaGyh.c"))) {
                file.write(str.toString());
            }
        }
        catch(IOException ex) {
            System.out.println("Erro ao salvar arquivo: " + ex.getMessage());
        }
        
        System.out.println(str.toString()); 
    }

    public SymbolTable getVarTable() { return varTable; }
    public void setVarTable(SymbolTable varTable) { this.varTable = varTable; }
    public ArrayList<Command> getCommand() { return command; }
    public void setCommand(ArrayList<Command> command) { this.command = command; }
}