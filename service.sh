#!/system/bin/sh

# Esperar a que el sistema termine de cargar (evita conflictos)
sleep 15

# ══════════════════════════════════════════════════════════
# LISTA DE JUEGOS (Solo añade el nombre del paquete aquí)
# ══════════════════════════════════════════════════════════
GAMES="
com.unknownworlds.subnauticabelowzero
com.activision.callofduty.shooter
com.WandaSoftware.TruckersofEurope3
com.miHoYo.GenshinImpact
com.netease.g108na
com.digitalextremes.warframemobile
com.rockstargames.rdr
com.rockstargames.gtasa
com.mojang.minecraftpe
com.dts.freefiremax
net.f8games.royale
com.zuuks.truck.simulator.ultimate
com.zuuks.bus.simulator.ultimate
com.rockstargames.gtalcs
"
# ══════════════════════════════════════════════════════════

log -t VULKAN_SWITCHER "Servicio de optimización iniciado"

# Estado inicial explícito
resetprop debug.hwui.renderer skiagl
resetprop ro.hwui.use_vulkan false
CURRENT_MODE="normal"

while true; do
    # 1. Obtener la aplicación que está actualmente en pantalla
    WINDOW=$(dumpsys window 2>/dev/null | grep -E 'mCurrentFocus|mFocusedApp' | head -2)

    # 2. Comprobación automática en la lista
    IS_GAME=false
    for GAME in $GAMES; do
        if echo "$WINDOW" | grep -q "$GAME"; then
            IS_GAME=true
            break # Si encuentra uno, deja de buscar para ahorrar CPU
        fi
    done

    # 3. Lógica de intercambio (Switcher)
    if [ "$IS_GAME" = true ]; then
        if [ "$CURRENT_MODE" != "vulkan" ]; then
            resetprop debug.hwui.renderer skiavk
            resetprop ro.hwui.use_vulkan true
            log -t VULKAN_SWITCHER "Modo Vulkan ACTIVADO"
            CURRENT_MODE="vulkan"
        fi
    else
        if [ "$CURRENT_MODE" != "normal" ]; then
            resetprop debug.hwui.renderer skiagl
            resetprop ro.hwui.use_vulkan false
            log -t VULKAN_SWITCHER "Modo OpenGL RESTAURADO"
            CURRENT_MODE="normal"
        fi
    fi

    sleep 3
done
