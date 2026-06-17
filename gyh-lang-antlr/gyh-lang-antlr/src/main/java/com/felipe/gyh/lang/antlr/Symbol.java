package com.felipe.gyh.lang.antlr;

public class Symbol {
    private String name;
    private int type;
    private String value;

    public static final int REAL = 0;
    public static final int INT = 1;
    
    public Symbol(String name, String type, String value){
        this.name = name;
        if (type.equals("INT")) this.type=INT;
        else this.type=REAL;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Symbol [name=" + this.name + ", type=" + type + ", value=" + value + "]";
    }
    
}
