/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.felipe.gyh.lang.antlr;

public class CommandEscrita extends Command {
    
    private String id;

    // Construtor idêntico ao que você chamou no .g4
    public CommandEscrita(String id) {
        this.id = id;
    }

    @Override
    public String generateCode() {
        // Formato simples da professora
        return "printf(\"%d\", " + id + ");";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}