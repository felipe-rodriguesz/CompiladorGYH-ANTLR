/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.felipe.gyh.lang.antlr;

import java.util.ArrayList;

/**
 *
 * @author Adm
 */
public class CommandCondicao extends Command {
    private String condition;
    private ArrayList<Command> listTrue;
    private ArrayList<Command> listFalse;

    public CommandCondicao(String cond, ArrayList<Command> lt, ArrayList<Command> lf) {
        this.condition = cond;
        this.listTrue = lt;
        this.listFalse = lf;
    }

    @Override
    public String generateCode() {
        String str = "if (" + condition + ") {\n";
        
        if (listTrue != null) {
            for (Command cmd : listTrue) {
                str += "\t" + cmd.generateCode() + "\n";
            }
        }
        
        str += "}";
        
        if (listFalse != null && !listFalse.isEmpty()) {
            str += " else {\n";
            for (Command cmd : listFalse) {
                str += "\t" + cmd.generateCode() + "\n";
            }
            str += "}";
        }
        
        return str;
    }

    // Getters e Setters
    public String getCondition() { return condition; }
    public void setCondition(String condition) { this.condition = condition; }
    public ArrayList<Command> getListTrue() { return listTrue; }
    public void setListTrue(ArrayList<Command> listTrue) { this.listTrue = listTrue; }
    public ArrayList<Command> getListFalse() { return listFalse; }
    public void setListFalse(ArrayList<Command> listFalse) { this.listFalse = listFalse; }
}
