#!/system/bin/sh
sleep 10

log -t SAFE "start"

# ═══════════════════════════════
# VBMETA / BOOT INTEGRITY
# ═══════════════════════════════
resetprop ro.boot.vbmeta.size 4096
resetprop ro.boot.vbmeta.hash_alg sha256
resetprop ro.boot.vbmeta.digest fa7c7e4466b8c58315a969969e474479379dabff62af7a18ab386eefaa823bd8
resetprop ro.boot.vbmeta.device_state locked
resetprop ro.boot.verifiedbootstate green
resetprop ro.boot.flash.locked 1
resetprop ro.boot.veritymode enforcing
resetprop ro.boot.warranty_bit 0
resetprop ro.boot.vbmeta.avb_version 2.0
resetprop ro.debuggable 0
resetprop ro.secure 1
resetprop ro.adb.secure 1

# ═══════════════════════════════
# UNITY GAME SCHEDULER
# ═══════════════════════════════
resetprop sched_thread_name UnityMain
resetprop sched_lib_name libunity.so:libil2cpp.so:libGameAssembly.so
resetprop sched_lib_mask_force 255

resetprop persist.sys.miui_anim_res_direct 1
resetprop persist.sys.miui_prio_render 1
# resetprop debug.gr.num_p_cur_frames 3
resetprop media.stagefright.cache 2048

# ═══════════════════════════════
# GPU / VULKAN
# ═══════════════════════════════
resetprop ro.adreno.agp.turbo 1
# [TEST GRABACION - SOSPECHOSO 2] resetprop debug.renderengine.graphite false
resetprop debug.renderengine.cache_shaders true
# [TEST GRABACION - SOSPECHOSO 3] resetprop debug.gralloc.enable_fb_ubwc 1
resetprop debug.egl.hw 1
resetprop persist.sys.force_sw_gles 0
# HWUI cache (afecta UI del sistema, no Unity directamente)
resetprop ro.hwui.texture_cache_size 88
resetprop ro.hwui.layer_cache_size 64
resetprop ro.hwui.r_buffer_cache_size 24
resetprop ro.hwui.gradient_cache_size 6
resetprop ro.hwui.path_cache_size 42
resetprop ro.hwui.drop_shadow_cache_size 6
resetprop ro.hwui.font_cache_size 8

# ═══════════════════════════════
# SURFACEFLINGER / FRAME PACING
# ═══════════════════════════════
# Evita que SF baje su tasa de refresco durante frames pesados (clave para Subnautica)
# resetprop debug.sf.set_idle_timer_ms 0
# resetprop ro.surface_flinger.set_idle_timer_ms 0

# Reduce presión de backpressure sin latch_unsignaled agresivo
# resetprop debug.sf.disable_backpressure 1
# resetprop debug.sf.enable_gl_backpressure 0

# Mejora el intercambio de buffers
# resetprop debug.egl.buffering_threshold 2

# ═══════════════════════════════
# CPU / SCHEDULER
# ═══════════════════════════════
resetprop persist.sys.dalvik.vm.lib.2 libart.so
resetprop ro.vendor.extension_library /vendor/lib/rfsa/adsp/libfastcvopt.so
# Wake rápido de cores desde estados de baja energía
resetprop ro.config.hw_quickpoweron 1
# Boost al hilo de render del top app (Unity se beneficia)
resetprop persist.sys.perf.topAppRenderThreadBoost.enable true

# ═══════════════════════════════
# MIUI / HYPEROS
# ═══════════════════════════════
resetprop persist.sys.miui.sf.vsync 1
resetprop persist.miui.speed_up_freeform true
resetprop persist.sys.miui_booster 1
resetprop persist.sys.smart_power 0
resetprop persist.sys.doze_powersave true
resetprop persist.sys.ui.hw 1
resetprop video.accelerate.hw 1
# Game Intelligence de HyperOS/MIUI
resetprop persist.miui.migt.enable 1
resetprop persist.miui.migt.game_boost 1

# ═══════════════════════════════
# I/O
# ═══════════════════════════════
resetprop persist.sys.job_delay true
resetprop ro.config.max_starting_bg 16

# ═══════════════════════════════
# ANIMACIONES Y TRANSICIONES
# ═══════════════════════════════
resetprop persist.sys.window_animation_scale 0.5
resetprop persist.sys.transition_animation_scale 0.5
resetprop persist.sys.animator_duration_scale 0.5

# ═══════════════════════════════
# INPUT / TOUCH
# ═══════════════════════════════
resetprop windowsmgr.max_events_per_sec 240
resetprop ro.input.noresample 1

# ═══════════════════════════════
# MEDIA / CODECS
# ═══════════════════════════════
# [TEST GRABACION - SOSPECHOSO 1] resetprop debug.stagefright.ccodec 1
# resetprop media.stagefright.enable-hw-codecs true
resetprop media.stagefright.enable-player true
resetprop media.stagefright.enable-meta true

# ═══════════════════════════════
# BLUETOOTH
# ═══════════════════════════════
resetprop persist.audio.bt.a2dp.hifi true
resetprop persist.bluetooth.a2dp.aac_whitelist true
resetprop persist.bluetooth.a2dp.aac_vbr true
resetprop persist.bluetooth.a2dp.aac_frame_ctl true

# ═══════════════════════════════
# AUDIO
# ═══════════════════════════════
resetprop audio.offload.buffer.size.kb 640
resetprop audio.offload.min.duration.secs 30
resetprop audio.deep_buffer.media true
resetprop audio.playback.capture.pcm.quality high
resetprop persist.vendor.audio.fluence.game false
resetprop persist.audio.fluence.voicecall true
resetprop persist.audio.fluence.speaker false
resetprop ro.qc.sdk.audio.fluencetype fluence
resetprop ro.audio.flinger_standbytime_ms 500
# Blur SystemUI (barra volumen, notificaciones, etc.)
resetprop ro.surface_flinger.supports_background_blur 0
resetprop persist.sys.sf.native_blur_supported 0
resetprop persist.sys.miui.blur_supported false
# SF ahora sabe que puede adquirir 3 buffers — coherente con num_p_cur_frames 3
#resetprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3
# Elimina el tracing de transacciones de SF en runtime — menos overhead interno
resetprop debug.sf.enable_transaction_tracing false
# Latencia de touch mínima — nota en menús y UI del juego
resetprop ro.min_pointer_dur 0
# resetprop persist.miui.migt.glthread 1
# GPU no se interrumpe a mitad de compilación de shader por otras tareas
# resetprop debug.adreno.preemption.disable 1

# Reutiliza imágenes EGL ya allocadas — menos overhead en la transición de entorno
# resetprop debug.sf.reuse_egl_images 1
# Asegurar compatibilidad con grabación y medios
# resetprop debug.sf.latch_unsignaled 1
# resetprop debug.sf.enable_gl_backpressure 1

resetprop --delete ro.modversion



log -t SAFE "done"
