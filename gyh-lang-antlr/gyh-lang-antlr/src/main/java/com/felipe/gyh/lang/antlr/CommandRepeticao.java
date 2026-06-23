/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.felipe.gyh.lang.antlr;

import java.util.ArrayList;

public class CommandRepeticao extends Command {
    private String condition;
    private ArrayList<Command> listWhile;

    public CommandRepeticao(String cond, ArrayList<Command> listWhile) {
        this.condition = cond;
        this.listWhile = listWhile;
    }

    @Override
    public String generateCode() {
        StringBuilder str = new StringBuilder();
        str.append("while (").append(condition).append(") {\n");
        
        if (listWhile != null) {
            for (Command cmd : listWhile) {
                str.append("\t\t").append(cmd.generateCode()).append("\n");
            }
        }
        
        str.append("\t}");
        return str.toString();
    }

    // Getters e Setters
    public String getCondition() { return condition; }
    public void setCondition(String condition) { this.condition = condition; }
    public ArrayList<Command> getListWhile() { return listWhile; }
    public void setListWhile(ArrayList<Command> listWhile) { this.listWhile = listWhile; }
}
