Mantengo éste script por motivos histórico-nostálgicos. Fue escrito allá por 2003, no esperes que funcione ;)

 SJemule-info 0.8 beta (para eMule 0.30 o posterior) [por Rodrigo Rega]


     Una vez descomprimido teclea en cualquier ventana de tu mirc:
       /load -rs directorio_del_addon\SJemule-info.mrc
  
  
  
     (Para que el addon funcione correctamente debes activar la opción
      de "Online-Signature" en tu eMule :: Preferencias>General)



;----------------------------------------------------------------
;
; Cambios desde la versión 0.72b:
;
; - Grandes cambios en el código. Está más claro, y se hacen menos operaciones
;   de lectura/escritura.
; - En los compartidos se muestran el número total de comentarios.
; - Ahora si se está desconectado del servidor del eMule se muestran las velocidades de 
;   subida y bajada y la cola de subidas (antes no lo hacia).
; - Muestra nueva información sobre la velocidad media de descargas/subidas.
;
;----------------------------------------------------------------
;
; Cambios desde la versión 0.6b:
;
; - Añadida una nueva opción en el popup para descargar el .zip con la última versión del addon.
; - Se pueden añadir eLinks o servidores al eMule desde el mIRC haciendo doble click sobre ellos.
; - Los records de descargas/subidas ahora se leen del preferences.ini.
; - Añadida información sobre el ratio de subidas/bajadas.
;
;----------------------------------------------------------------
:
; Cambios desde la versión 0.5b:
; 
; - Esta nueva versión no es compatible con las versiones anteriores a la 0.30.
; - Si cancelabas al cambiar la rula mostraba "ruta cambiada". Arreglado.
; - No se comprueba si existe el archivo emule.exe, ahora podrás tenerlo con cualquier nombre.
; - Ahora no detectará las versiones del emule anteriores a la 0.25.
;
;----------------------------------------------------------------
;
; Cambios desde la versión 0.41b:
;
; - Añadida información de la versión del eMule.
;----------------------------------------------------------------
;
; Cambios desde la versión 0.3b:
;
; - Arreglado un bug que impedia que se actualizasen los records.
; - Algunos cambios visuales.
; - Cuando no hay archivos compartidos se muestra la información correctamente.
; - En los totales transefidos se puede ver también la fecha de inicio.
;
;----------------------------------------------------------------
;
; Cambios desde la versión 0.2b:
;
; - Añadida compatibilidad con el gestor de addons del script IRcap.
; - Nueva opción para configurar la ruta del eMule.
; - Simplificado el modo de mostrar la información.
; - Varios cambios en el código.
;
;----------------------------------------------------------------
;
; Cambios desde la versión 0.11b:
;
; - Ahora se puede mostrar la información individualmente. (por Bad_CRC)
; - Si ya está configurada la rula del eMule, al recargar el script no vuelve
;   a preguntarla.
; - Los records de descargas y subidas ya no se ponen a 0 al recargar el script.
; - Otros pequeños cambios en el código.
;
;----------------------------------------------------------------