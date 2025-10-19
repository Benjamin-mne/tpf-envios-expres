# Envíos Exprés — Trabajo Práctico Final

**Licenciatura en Sistemas de Información**  
**Fundamentos de Programación (2025)**  
**Esp. Lic. Escalante Julián**  
**Ayudantes:** Sanchez Hernán, Blanc Maitén  

---

## 📦  Descripción del proyecto

El proyecto **“Envíos Exprés”** consiste en el desarrollo de una aplicación en **Pascal** que permite **gestionar los envíos diarios** de una empresa de logística nacional.  

El sistema administra los datos de los envíos mediante **archivos de tipo registro**, ofreciendo funcionalidades de carga, búsqueda, ordenamiento, listado y actualización de estados.


## 🧩 Compilación

Para compilar el proyecto completo:

1. Asegúrate de tener **Free Pascal (fpc)** instalado y agregado al **PATH**.  
   👉 [Descargar Free Pascal](https://www.freepascal.org/download.html)

2. Ejecuta el archivo **`compilar.bat`** (haciendo doble clic o desde la terminal).

El script hará lo siguiente:
- Creará la carpeta `bin` si no existe.  
- Compilará las *units* en el siguiente orden:
  1. `src/model/envio.pas`  
  2. `src/utils/DAOUtils.pas`  
  3. `src/dao/DAOenvio.pas`  
  4. `src/controller/ControllerEnvio.pas`  
  5. `src/view/menu.pas`
- Luego compilará el programa principal: `src/main.pas`.
- Guardará el ejecutable final como **`bin/TPF.exe`**.
- Finalmente eliminará los archivos temporales (`.o`, `.ppu`).

---

## ▶️ Ejecución

Una vez compilado correctamente, abrí la carpeta **`bin`** y ejecutá:

```bash
TPF.exe
```

## 🏗️ Arquitectura del Proyecto

El proyecto está organizado en módulos (*units*) separados por su función dentro del programa.  
Cada módulo cumple un propósito específico y se comunica con los demás mediante procedimientos y funciones.  
Este enfoque facilita mantener el código ordenado, comprensible y fácil de ampliar.

```bash
/
├── src/
│   ├── model/
│   │   └── envio.pas
│   ├── utils/
│   │   └── DAOUtils.pas
│   │   └── TestUtils.pas
│   │   └── Utils.pas
│   ├── dao/
│   │   └── DAOenvio.pas
│   ├── controller/
│   │   └── ControllerEnvio.pas
│   ├── view/
│   │   └── menu.pas
│   └── main.pas
│
├── bin/
│   └── TPF.exe         # Ejecutable generado
│
├── data/
│   └── envio.dat       # Datos generados
│
├── compilar.bat        # Script de compilación
└── README.md           # Documentación
```
---

### 1. 🧩 Model (Modelo)
**Ubicación:** `src/model/`

El módulo **Model** define las **estructuras de datos** utilizadas por el programa.  
Aquí se declaran los registros (`record`) que representan la información que se maneja.

**Ejemplo:**  
`envio.pas` define el registro `TEnvio`, que contiene los campos necesarios para describir un envío (como código, destino, peso, etc.).

**Responsabilidades:**
- Definir los tipos de datos y constantes principales.  
- No acceder directamente a archivos ni mostrar información al usuario.

---

### 2. ⚙️ DAO (Data Access Object)
**Ubicación:** `src/dao/`

La capa **DAO** maneja el **acceso a los datos almacenados en archivos**.  
Contiene los procedimientos encargados de abrir, leer, escribir y actualizar los archivos `.dat`.

**Ejemplo:**  
`DAOenvio.pas` permite guardar o leer registros de `envio.dat` en la carpeta `data`.

**Responsabilidades:**
- Leer y escribir los registros definidos en `model`.  
- Controlar la apertura y cierre de archivos.  
- Aislar la lógica de almacenamiento del resto del programa.

---

### 3. 🧠 Controller (Controlador)
**Ubicación:** `src/controller/`

El **controlador** coordina la ejecución del programa.  
Recibe las acciones que el usuario elige desde el menú y llama a los procedimientos de las otras unidades según corresponda.

**Ejemplo:**  
`ControllerEnvio.pas` gestiona las operaciones sobre los envíos (agregar, modificar, listar), utilizando las units de `DAO` y `Model`.

**Responsabilidades:**
- Controlar el flujo general del programa.  
- Llamar a los procedimientos de lectura y escritura.  
- Evitar que la vista o los módulos de datos dependan entre sí.

---

### 4. 🖥️ View (Vista)
**Ubicación:** `src/view/`

La **vista** se encarga de la **interacción con el usuario** mediante la consola.  
Contiene los menús, mensajes y lectura de opciones o datos.

**Ejemplo:**  
`menu.pas` muestra las opciones disponibles y recibe la elección del usuario.

**Responsabilidades:**
- Mostrar información por pantalla.  
- Leer datos ingresados desde el teclado.  
- No realizar cálculos ni operaciones sobre los datos.

---

### 5. 🛠️ Utils (Utilidades)
**Ubicación:** `src/utils/`

El módulo **Utils** contiene **funciones auxiliares** que pueden usarse en diferentes partes del programa.  
No pertenecen a una unidad específica, pero ayudan a mantener el código más limpio y reutilizable.

**Ejemplo:**  
`DAOUtils.pas` incluye rutinas de validación, manejo de archivos o formateo de texto.

**Responsabilidades:**
- Proporcionar herramientas comunes a varios módulos.  
- Evitar repetir código en distintas partes del programa.

---

### 🧭 Flujo general del programa

<pre>
┌──────────┐      ┌──────────────┐      ┌─────────────┐      ┌──────────┐
│   View   │ ---> │  Controller  │ ---> │     DAO     │ ---> │   Data   │
│  (menu)  │ <--- │  (coordina)  │ <--- │  (archivos) │ <--- │  (.dat)  │
└──────────┘      └──────────────┘      └─────────────┘      └──────────┘
</pre>
