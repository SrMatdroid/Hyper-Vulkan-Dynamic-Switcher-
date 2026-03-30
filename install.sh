##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################

SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true

##########################################################################################
# REPLACE LIST
##########################################################################################

REPLACE="
"

##########################################################################################
# MAIN FUNCTIONS
##########################################################################################

print_modname() {
  ui_print " "
  ui_print "  ╔═══════════════════════════════════╗"
  ui_print "  ║     VULKAN AUTO-SWITCHER MOD      ║"
  ui_print "  ║          by Sr.Mat  v12           ║"
  ui_print "  ╚═══════════════════════════════════╝"
  ui_print " "
}

on_install() {
  ui_print "  ──────────────────────────────────"
  ui_print "   DISPOSITIVO"
  ui_print "  ──────────────────────────────────"
  ui_print "  • Modelo  : $(getprop ro.product.model)"
  ui_print "  • Android : $(getprop ro.build.version.release)"
  ui_print "  • Kernel  : $(uname -r)"
  ui_print " "

  ui_print "  ──────────────────────────────────"
  ui_print "   INSTALACIÓN"
  ui_print "  ──────────────────────────────────"
  ui_print "- Extrayendo archivos del módulo..."
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  unzip -o "$ZIPFILE" 'common/*' -d $MODPATH >&2

  ui_print "  [✓] Script de auto-Vulkan preparado"

  if [ -f "$MODPATH/system.prop" ]; then
    ui_print "  [✓] system.prop detectado y cargado"
  else
    ui_print "  [!] system.prop omitido (archivo oculto/ausente)"
  fi

  ui_print "  [✓] Permisos de ejecución configurados"
  ui_print " "
  ui_print "  ──────────────────────────────────"
  ui_print "   ✓ Instalación completada"
  ui_print "  ──────────────────────────────────"
  ui_print " "
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm $MODPATH/system/build.prop 0 0 0644 u:object_r:system_prop:s0
  set_perm $MODPATH/common/post-fs-data.sh 0 0 0755
  set_perm $MODPATH/common/service.sh 0 0 0755
}