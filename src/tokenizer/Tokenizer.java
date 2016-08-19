/*
 * Copyright (C) 2016 Dhaby Xiloj <dhabyx@gmail.com>.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */
package tokenizer;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dhaby Xiloj <dhabyx@gmail.com>
 */
public class Tokenizer {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        FileReader archivo;
        try {
            // Lectura de archivo fuente
            archivo = new FileReader("src"+File.separator+"tokenizer"
                    + File.separator + "entrada.txt");
            
            // Instanciación del Analizador Léxico generado
            AnalizadorLexico analizadorLexico = new AnalizadorLexico(archivo);
            
            // Ejecución del analizador léxico
            analizadorLexico.yylex();
            
            archivo.close();
            
        } catch (IOException ex) {
            Logger.getLogger(Tokenizer.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
}
