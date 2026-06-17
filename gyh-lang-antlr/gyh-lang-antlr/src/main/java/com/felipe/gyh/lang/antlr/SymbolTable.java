package com.felipe.gyh.lang.antlr;

import java.util.HashMap;

public class SymbolTable {
    private HashMap<String, Symbol> table;

    public SymbolTable() {
        table = new HashMap<String, Symbol>();
    }

    public void add(Symbol symbol) {
        table.put(symbol.getName(), symbol);
    }

    public boolean exists(String name) {
        return table.get(name)!=null;
    }

    public Symbol get(String symbolName) {
        return table.get(symbolName);
    }

    public int getVariableType(String name) {
        Symbol sym = get(name);
        if (sym != null) return sym.getType();
        return -1;
    }
}
