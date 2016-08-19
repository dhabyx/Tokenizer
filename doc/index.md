# Documentación

## Librería JFlex

Para que la aplicación funcione adecuadamente debe de tener en cuenta que el proyecto deberá tener el binario precompilado de JFlex, el cual debe de ser descargado de la página oficial de [JFlex](http://jflex.de/download.html) y colocado en una carpeta */libs*, quedando de la siguiente manera:

    /nbprojects
      /Tokenizer
      /libs
        jflex-[versión].jar

Donde la carpeta nbprojects es la carpeta donde netbeans crea por defecto los proyectos, por lo que la carpeta del proyecto debe estar al mismo nivel que la carpeta libs.

Ésta restricción está de ésta manera para que sea fácil agregar la librería sin necesidad de gestionarla dentro del mismo proyecto de netbeans. Además el proyecto está configurado para cargar la librería de JFlex mediante la ruta relativa "../libs/jflex-[version].jar"

En caso de que la versión cambie o desee mover la misma a otra dirección, por favor utilice las preferencias del proyecto.

## El archivo de JFlex

Un archivo de JFlex puede tener cualquier extensión, por lo que para llevar un estándar fácil de comprender se utiliza la extensión .jflex

Éste archivo se puede encontrar en la misma carpeta donde se encuentra el código fuente del proyecto Tokenizer: "src/tokenizer/". Esto se hace para hacer mas fácil el trabajo del mismo, pero en proyectos mucho mas elaborados debería de encontrarse en un paquete aparte o bien en una carpeta especial.

## Estructura elemental del archivo JFlex

Un documento de JFlex tiene tres secciones principales:

* Código de usuario
* Opciones y declaraciones
* Reglas léxicas

Cada sección está dividida por "%%" y los comentarios siempre deben de estar encerrados por los conjuntos de caracteres /\* y \*/ como en Java.

El archivo se usa como plantilla para generar una clase con código Java, por lo que es importante que comprenda que mucho del código funcionará como si fuese un archivo .java el cual contendrá un analizador léxico según las reglas que especifiquemos.

A continuación podemos observar un archivo muy básico de ejemplo, para conocer mas opciones visite la página de la [documentación de JFlex](http://jflex.de/manual.html)

```JFlex
/**
 * Sección de código de usuario:
 *
 * En ésta sección se puede agregar cualquier cabecera
 * importante para  que funcione, en especial el
 * paquete y los imports.
 */

/** Cargando el nombre del paquete **/
package tokenizer;

/* Se cargan los imports que sean necesarios */
import alguna.biblioteca.importante

%%
/**
 * Sección de opciones y declaraciones:
 *
 * En ésta sección se colocan opciones que usa JFlex
 * para generar una clase y también contiene las
 * expresiones regulares que serán utilizadas para
 * reconocer cada Token
 *
 * A continuación se colocan algunas de las mas
 * importantes para generar un aanalizador léxico
 * básico
 */

/* nombre de la clase que será generada */
%class AnalizadorLexico

/* utilización de caracters UNICODE */
%unicode

/* Cargar el número de línea en que se
   obtiene el token */
%line

/* Cargar el número de columna en que se
   obtiene el token */
%column

/* Se especifica el tipo de dato que se utiliza
   como retorno de la función que realiza la lectura
   de cada lexema yylex() */
%type String        

/* Código que es copiado directamente a la clase
   generada por JFlex */
%{
    private String numeros = "";
%}

/* Código que es copiado a el método encargado
   de determinar el fin del archivo, por lo que
   se ejecuta al finalizar de leer el mismo */
%eof{
    System.out.println("Numeros encontrados:");
    System.out.println(numeros);
%eof}

/* Sección de Declaración de Expresiones regulares
   Expresion = RegExp
   Expresion = {otra expresion}RegExp */
FinLinea = \r|\n|\r\n
Espacios = {FinLinea} | [ \t\f]
Decimal = 0 | [1-9][0-9]*

%%

/**
 * Sección de reglas léxicas
 *
 * Su sintaxis es simple:
 * "RegExp" { código a ejecutar }
 * {Declaración} { código a ejecutar }
 *
 * IMPORTANTE:
 * El órden es importante, la primera regla con la
 * que coincida es la que se aplica.
 */

";" { /* ignorar */ }
{Decimal} { numeros += "["+ yyline + ":"+ yycolumn + "] " + yytext() + "\n"; }
{Espacios} {  }
. { System.err.println("ERROR: Caracter invalido" + yytext() + "["+ yyline + ":"+ yycolumn + "]"); }

```

## Creación del Analizador Léxico

Para crear el analizador léxico se debe de ejecutar la clase **GenJFlex.java**, la cual generará la clase del Analizador Léxico que es requerida por la clase Tokenizer.

## Ejecución

La entrada de datos es cargada del archivo "entrada.txt" que se encuentra en la misma carpeta del código fuente "src/tokenizer/entrada.txt"
