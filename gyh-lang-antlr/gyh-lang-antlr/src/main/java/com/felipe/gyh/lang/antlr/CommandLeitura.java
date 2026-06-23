/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.felipe.gyh.lang.antlr;

public class CommandLeitura extends Command {
    
    private String id;

    public CommandLeitura(String id) {
        this.id = id;
    }

    @Override
    public String generateCode() {
        return "scanf(\"%d\", &" + id + ");";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}