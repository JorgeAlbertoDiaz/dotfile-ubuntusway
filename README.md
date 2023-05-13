# Dotfile-ubuntusway 
Archivos de configuraci'on para la distribuci'on de Ubuntu con Sway

Para organizar y centralizar los archivos de configuración opté por usar la herramienta `stow`.

## Requisitos
Necesitarás tener instalado `git` y `stow`.

## Instalación
- Debes clonar el repositorio dentro de tu directorio `$HOME` o `~`.

```bash
git clone git@github.com:JorgeAlbertoDiaz/dotfiles.git
```

- Ejecuta el comando `stow` para crear un symlink de todo o solo selecciona lo que quieres.

```bash
stow */
```

> La barra `/` ignora el archivo `README.md`, o bien puedes escribir el comando seguido del nombre de la carpeta para levantar solo esa configuración.


