; SJemule-info 0.8 beta (para eMule 0.30 o posterior) [por Rodrigo Rega] rodrigorega@gmail.com
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
#info on
[info]
name=SJemule-info
author=Rodrigo Rega
version=0.8b
desc=Muestra información (Privada o pública) sobre el programa peer to peer "eMule" (Versión, servidor, descargas, records, compartidos...).

[ADDON]
nombre=SJemule-info
autor=Rodrigo Rega
ver=0.8b
unload=unload.sjemule
desc=Muestra información (Privada o pública) sobre el programa peer to peer "eMule" (Versión, servidor, descargas, records, compartidos...).
#info end

menu channel,query {
  -
  SJeMule-info
  .&Información a $active 
  ..&eMule Status : sjemule nopriv
  ..-
  ..Emule Version: showEmuleVer nopriv
  ..&Nick : showNick nopriv
  ..&Servidor : showServer nopriv
  ..&Transferencias : showTransfers nopriv
  ..&Velocidades Medias: showMediaTransf nopriv
  ..&Ratio: showRatio nopriv
  ..&Records : showRecords nopriv
  ..&Total Tranferido : showTotal nopriv
  ..&Cola de Subida : showQueue nopriv
  ..Co&mpartidos : showShared nopriv
  ..&Add On Version : showVersion nopriv

  .Infomación &privada 
  ..&eMule Status : sjemule priv 
  ..-
  ..Emule Version: showEmuleVer priv
  ..&Nick : showNick priv
  ..&Servidor : showServer priv
  ..&Transferencias : showTransfers priv
  ..&Velocidades Medias: showMediaTransf priv
  ..&Ratio: showRatio priv
  ..&Records : showRecords priv
  ..&Total Tranferido : showTotal priv
  ..&Cola de Subida : showQueue priv
  ..Co&mpartidos : showShared priv
  ..&Add On Version : showVersion priv
  .-
  .Configurar &Ruta : configRoot
  .&Desinstalar SJemule-info : unload.sjemule
  .Descargar última versión: /run http://offline/SJemule-info.zip
  -
}
on *:load: { 
  .timermaxupdown off
  if ( !$read.config(emule_root) ) { configRoot }
  echo -a *** SJemue-info 0.8 beta [by Rodrigo Rega] rodrigorega@gmail.com Instalado correctamente
}
on *:unload: { echo -a *** SJemule-info Desinstalado correctamente. }
alias unload.sjemule { .unload -rs $script }
on ^1:HOTLINK:ed2k?//|*|*|*|/:*:{ return }
on 1:HOTLINK:ed2k?//|*|*|*|/:*:{ run $read.config(emule_root) $+ emule.exe $1- }

alias -l configRoot {
  var %temp.sdir | %temp.sdir = $sdir="¿Directorio del eMule?"
  if ( %temp.sdir ) { save.config emule_root %temp.sdir | echo -a *** Ruta del eMule asignada a: %temp.sdir }
}
alias -l showEmuleVer    { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ ) }
alias -l showNick        { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Nick) $returnNick }
alias -l showServer      { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Servidor) $returnServer }
alias -l showTransfers   { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Transferencias D/U) $returnTransfers }
alias -l showMediaTransf { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Media D/U) $returnMediaTransf }
alias -l showRatio       { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Ratio D/U) $returnRatio }
alias -l showRecords     { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Records D/U) $returnRecords }
alias -l showTotal       { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Total Transferido D/U) $returnTotal -Desde $returnDateInst $+ - }
alias -l showQueue       { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Cola de Subidas) $returnQueue }
alias -l showShared      { comprueba.archivos | $ModeShow($$1) (eMule $returnEmuleVer $+ : Compartidos) $returnShared $+(-,$returnComents comentarios,-) |   unset %total.numero.shares | unset %total.size.shares }
alias -l showVersion     {                      $ModeShow($$1) (SJeMule-info) $returnVersion }

alias -l sjemule {
  comprueba.archivos
  $ModeShow($$1) [SJeMule-info $returnVersion $+ ] (Nick) $returnNick (Usando) eMule $returnEmuleVer
  $ModeShow($$1) (Servidor) $returnServer
  $ModeShow($$1) (Transferencias D/U) $returnTransfers (Media D/U) $returnMediaTransf (Records D/U) $returnRecords
  $ModeShow($$1) (Total Transferido D/U) $returnTotal (Ratio D/U) $returnRatio -Desde $returnDateInst $+ -
  $ModeShow($$1) (Compartidos) $returnShared $+(-,$returnComents comentarios,-) (Bajando) $returnMyQueue (Cola de Subidas) $returnQueue
  unset %total.numero.shares | unset %total.size.shares
}
alias -l ModeShow { return $iif($$1 == priv,echo -a,say) }

alias -l returnVersion     { return 0.8b }
alias -l returnNick        { return $readPrefIni(emule,nick) }
alias -l returnEmuleVer    { return $readPrefIni(emule,AppVersion) }
alias -l returnTotal       { return $+($size($readPrefIni(statistics,TotalDownloadedBytes)),/,$size($readPrefIni(statistics,TotalUploadedBytes))) }
alias -l returnRatio       { tokenize 32 $calcRatio | return $+($1,/,$2) }
alias -l returnRecords     { return $+($round($readPrefIni(statistics,ConnMaxDownRate),1),/,$round($readPrefIni(statistics,ConnMaxUpRate),1)) KB/s }
alias -l returnDateInst    { return $asctime($file($read.config(emule_root) $+ config\preferences.dat).ctime,dd/mm/yyyy) }
alias -l returnComents     { return $ini($read.config(emule_root) $+ config\fileinfo.ini,0) }
alias -l returnMyQueue     { return $findfile($readPrefIni(emule,TempDir),*.part,0) archivos }
alias -l returnMediaTransf { return $+($round($readPrefIni(statistics,ConnAvgDownRate),1),/,$round($readPrefIni(statistics,ConnAvgUpRate),1)) KB/s }
alias -l returnServer {
  if ( $gettok($read($read.config(emule_root) $+ onlinesig.dat,t,1),1,$chr(10)) != 0 ) {
    var %temp.ifmatch = $ifmatch
    return $gettok(%temp.ifmatch,2,124) : $+(ed2k://|server|,$gettok(%temp.ifmatch,3,124),|,$gettok(%temp.ifmatch,4,124),|/)  
  }
  else { return Desconectado }
}
alias -l returnTransfers {
  var %ifmatch.replace = $replace($read($read.config(emule_root) $+ onlinesig.dat,$queLinea),$chr(44),$chr(46))
  return $+($iif($gettok(%ifmatch.replace,1,124) != 0.0,$ifmatch, -),/,$iif($gettok(%ifmatch.replace,2,124) != 0.0,$ifmatch, -)) KB/s 
}
alias -l returnQueue {
  var %ifmatch.replace = $replace($read($read.config(emule_root) $+ onlinesig.dat,$queLinea),$chr(44),$chr(46))
  return $iif($gettok(%ifmatch.replace,3,124),$ifmatch, -)
}
alias -l queLinea { if ( $gettok($read($read.config(emule_root) $+ onlinesig.dat,t,1),1,$chr(10)) != 0 ) { return 2 } | else { return 1 } }
alias -l returnShared {
  set %total.numero.shares 0 | set %total.size.shares 0
  share.files $readPrefIni(emule,IncomingDir) 
  var %fichero.shares = $read.config(emule_root) $+ config\shareddir.dat
  if ( %fichero.shares ) {
    var %cont.dir.shares 1
    while ( $read(%fichero.shares,%cont.dir.shares) ) { share.files $ifmatch | inc %cont.dir.shares }
  }
  return $iif($size(%total.size.shares) != 0b,$ifmatch en %total.numero.shares archivos,0 archivos)
}

alias -l share.files {
  var %cont.shares 1 | var %cont.size.shares
  while ( $findfile($$1-,*.*,%cont.shares,1) ) { 
    %cont.size.shares = $calc(%cont.size.shares + $file($ifmatch).size) | inc %cont.shares 
  }
  dec %cont.shares
  %total.numero.shares = $calc(%total.numero.shares + %cont.shares)
  %total.size.shares = $calc(%total.size.shares + %cont.size.shares)
}
alias -l calcRatio {
  if ( ( $readPrefIni(statistics,TotalUploadedBytes) != 0 ) && ( $readPrefIni(statistics,TotalDownloadedBytes) != 0 ) ) {
    if ( $readPrefIni(statistics,TotalDownloadedBytes) > $readPrefIni(statistics,TotalUploadedBytes) ) { return $round($calc($readPrefIni(statistics,TotalDownloadedBytes)/$readPrefIni(statistics,TotalUploadedBytes)),2) 1 }
    else { return 1 $round($calc($readPrefIni(statistics,TotalUploadedBytes)/$readPrefIni(statistics,TotalDownloadedBytes)),2) }
  }
  else { return - - }
}
alias -l save.config   { if ( $2 ) { writeini $scriptdir\emuleinfo.ini config $$1- } }
alias -l read.config   { return $readini($scriptdir\emuleinfo.ini,config,$1-) }
alias -l readPrefIni   { return $readini($read.config(emule_root) $+ config\preferences.ini,$1,$2-) }

alias -l size { if ($1 < 0) || ($1 !isnum) { return n/a } | if ($round($calc($1 / 1000000000000),2) >= 1) { return $round($calc($1 / 1099511627776),2) $+ TB } | if ($round($calc($1 / 1000000000),2) >= 1) { return $round($calc($1 / 1073741824),2) $+ GB } | if ($round($calc($1 / 1000000),1) >= 1) { return $round($calc($1 / 1048576),1) $+ MB } | if ($round($calc($1 / 1000),1) >= 1) { return $round($calc($1 / 1024),1) $+ KB } | return $int($1) $+ B }
alias -l comprueba.archivos {
  if ( !$exists($read.config(emule_root) $+ onlinesig.dat) )   { echo -a * ERROR: No existe el archivo onlinesig.dat.      (Para que el addon funcione correctamente debes activar la opción de "Online-Signature" en tu eMule :: Preferencias>General) | halt }
  if ( !$exists($read.config(emule_root) $+ config\preferences.ini) ) { echo -a * ERROR: No existe el archivo config\preferences.ini. | halt }
}
