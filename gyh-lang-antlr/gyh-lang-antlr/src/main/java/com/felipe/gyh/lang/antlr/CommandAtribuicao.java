/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.felipe.gyh.lang.antlr;

public class CommandAtribuicao extends Command {
    
    private String id;
    private String expr;

    public CommandAtribuicao(String id, String expr) {
        this.id = id;
        this.expr = expr;
    }

    @Override
    public String generateCode() {
        return id + " = " + expr + ";";
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getExpr() { return expr; }
    public void setExpr(String expr) { this.expr = expr; }
}